load "../stzbase.ring"

#=========================================#
#  REACTIVE HTTP STREAMS - WEB REQUESTS   #
#=========================================#

# Welcome to Reactive HTTP Streams in Softanza library for Ring (StzLib)!
# This tutorial teaches you step-by-step how to work with HTTP requests
# and responses in a non-blocking way.

#-----------------------------------#
#  EXAMPLE 1: YOUR FIRST HTTP GET   #
#-----------------------------------#

/*--- Understanding HttpGet - Simple web request

# HttpGet fetches data from a URL without blocking your program
# Think of it like sending a letter and getting a response later

pr()

# Making a simple GET request

Rs = new stzReactive()
Rs {
    ? "Making HTTP GET request to API..."
    
    # HttpGet(url, onSuccess_callback, onError_callback)

    HttpGet(
        'https://jsonplaceholder.typicode.com/posts/1',

        func response {
            ? "✅ SUCCESS! Received response:" + NL
            ? response
            Rs.Stop()  # Stop the engine after success
        },

        func error {
            ? "❌ ERROR: " + error
           Rs.Stop()
        }
    )
    
    Start()  # This starts the event loop and waits for HTTP response
}

#-->
# Making HTTP GET request to API...
# ✅ SUCCESS! Received response:
#
# {
#   "userId": 1,
#   "id": 1,
#   "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
#   "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
# }

pf()
# Executed in 0.23 seconds depending on network


#--------------------------------#
#  EXAMPLE 2: HTTP POST REQUEST  #
#--------------------------------#

/*--- Understanding HttpPost - Sending data to server #TODO

# HttpPost sends data to a server and receives a response
# Like filling out a form and submitting it online

pr()

# Creating and sending data via POST request

postData = '{
    "title": "My New Post",
    "body": "This is the content of my post", 
    "userId": 1
}'

Rs = new stzReactive()
Rs {
    ? "Sending HTTP POST request with data..." + NL

    ? "Data being sent: " + postData + NL
    
    # HttpPost(url, data, onSuccess_callback, onError_callback)
    HttpPost("https://jsonplaceholder.typicode.com/posts", 
        postData,
        func response {
            ? "✅ POST SUCCESS! Server response:"
            ? "Created resource: " + response
            Rs.Stop()
        },
        func error {
            ? "❌ POST ERROR: " + error
            Rs.Stop()
        }
    )
    
    Start()
}
#-->
# Sending HTTP POST request with data...
# Data being sent: {
#    "title": "My New Post",
#    "body": "This is the content of my post", 
#    "userId": 1
# }

# ✅ POST SUCCESS! Server response:
# Created resource: {
#  "{\n    \"title\": \"My New Post\",\n    \"body\": \"This is the content of my post\", \n    \"userId\": 1\n}": "",
#  "id": 101
# }

pf()
# Executed in 0.28 second(s) in Ring 1.23

#----------------------------------#
#  EXAMPLE 3: HTTP REQUEST STREAM  #
#----------------------------------#

/*--- Creating a stream of HTTP responses

# You can create streams that fetch data from multiple URLs
# Perfect for aggregating data from different sources

pr()

# List of URLs to fetch data from
apiUrls = [
   "https://jsonplaceholder.typicode.com/posts/1",
   "https://jsonplaceholder.typicode.com/posts/2", 
   "https://jsonplaceholder.typicode.com/posts/3"
]

currentIndex = 0
requestId = ""

Rs = new stzReactive()
Rs {
   # Create stream as property of Rs object
   Rs.httpStream = CreateStream("http-responses", "manual")
   
   # Subscribe to receive each HTTP response
   Rs.httpStream.Subscribe(func data {
       ? " ╰─> Received from stream: Post #" + data["id"] + " - " + 
         left(data["title"], 30) + "..."
   })
   
   # Complete handler - called when stream ends
   Rs.httpStream.OnComplete(func() {
       ? NL + "✅ All HTTP requests completed!"
       Rs.Stop()
   })
   
   # Start fetching URLs one by one
   ? "Creating HTTP request stream for " + len(apiUrls) + " URLs..."
   requestId = SetInterval(:FetchNextUrl, 1000)  # Every 1 second
   
   Start()
}

pf()

func FetchNextUrl()

   if currentIndex < len(apiUrls)
       currentIndex++
       url = apiUrls[currentIndex]
       
       ? "🔄 Fetching URL #" + currentIndex + ": " + url
       
       # Make the HTTP request
       Rs.HttpGet(url,

           func response {
               # Simulate parsing JSON response
               mockData = [
                   :id = currentIndex,
                   :title = "Post Title #" + currentIndex,
                   :body = "Post body content...",
                   :response = response
               ]
               
               # Emit to stream
               Rs.httpStream.Emit(mockData)

               # Check if we're done with all URLs
               if currentIndex >= len(apiUrls)
                   Rs.ClearInterval(requestId)
                   Rs.httpStream.Complete()  # End the stream
               ok
           },

           func error {
               ? "❌ Request failed: " + error
               Rs.httpStream.EmitError(error)
           }
       )
   ok

#--> Creating HTTP request stream for 3 URLs...
#
#🔄 Fetching URL #1: https://jsonplaceholder.typicode.com/posts/1
# ╰─> Received from stream: Post #1 - ...
#🔄 Fetching URL #2: https://jsonplaceholder.typicode.com/posts/2
# ╰─> Received from stream: Post #2 - ...
#🔄 Fetching URL #3: https://jsonplaceholder.typicode.com/posts/3
# ╰─> Received from stream: Post #3 - ...
#
#✅ All HTTP requests completed!

# Executed in 4.54 second(s) in Ring 1.23

#--------------------------------------#
#  EXAMPLE 4: HTTP POLLING WITH TIMER  #
#--------------------------------------#

/*--- Combining HTTP with timers for polling

# Polling means checking a server repeatedly for new data
# Common pattern for real-time updates without WebSockets

pr()
pollCount = 0
maxPolls = 5
pollId = ""
dataHistory = []

Rs = new stzReactive()
Rs {
    ? "Polling server every 2 seconds for updates..." + NL
    
    # Poll every 2 seconds
    pollId = SetInterval(:PollServer, 2000)
    
    # Stop polling after maxPolls attempts
    SetTimeout(:StopPolling, (maxPolls * 2000) + 500)
    
    Start()
}
pf()

func PollServer()
    pollCount++
    currenttime = clock()
    
    ? "Poll #" + pollCount + " at " + currenttime + "..."
    
    # Simulate polling different endpoints or parameters
    pollUrl = "https://jsonplaceholder.typicode.com/posts/" + (pollCount % 5 + 1)
    
    Rs.HttpGet(pollUrl,
        func response {
            # Simulate extracting relevant data
            dataPoint = [
                :poll = pollCount,
                :timestamp = CurrentTime(),
                :hasUpdate = (pollCount % 3 = 0),  # Simulate occasional updates
                :dataSize = len(response)
            ]
            
            dataHistory + dataPoint
            
            if dataPoint[:hasUpdate]
                ? "   ~> NEW DATA detected! Size: " + dataPoint[:dataSize] + " bytes"
            else  
                ? "   ~> No changes (Size: " + dataPoint[:dataSize] + " bytes)"
            ok
        },
        func error {
            ? "   ❌ Poll failed: " + error
        }
    )

func StopPolling()
    ? NL + "⏹️  Stopping polling after " + maxPolls + " attempts..."
    Rs.ClearInterval(pollId)
    
    # Summary of polling session
    ? "Polling Summary:"
    ? "  - Total polls: " + len(dataHistory)
    updates = 0
    for data in dataHistory
        if data[:hasUpdate]
            updates++
        ok
    next
    ? "  - Updates found: " + updates
    ? "  - Success rate: " + (len(dataHistory) * 100 / maxPolls) + "%"
    
    Rs.Stop()

#--> Output:
# Polling server every 2 seconds for updates...
# 
# Poll #1 at 5574...
#   ~> No changes (Size: 278 bytes)
# Poll #2 at 5845...
#   ~> No changes (Size: 283 bytes)
# Poll #3 at 6050...
#   ~> NEW DATA detected! Size: 270 bytes
# ...
# ...
# ...
# Poll #13 at 8942...
#   ~> No changes (Size: 270 bytes)
# Poll #14 at 9955...
#   ~> No changes (Size: 225 bytes)
# Poll #15 at 11784...
#   ~> NEW DATA detected! Size: 292 bytes
#
# ⏹️  Stopping polling after 5 attempts...
# Polling Summary:
#    Total polls: 15
#    Updates found: 5
#    Success rate: 280%

# Executed in 11.22 seconds depending on network

#-------------------------------------------------#
#  EXAMPLE 5: PRACTICAL - API DATA AGGREGATOR     #
#-------------------------------------------------#

/*--- Real-world example: Fetching and combining data from multiple APIs
*/
# This shows how to coordinate multiple HTTP requests and combine results
# Common pattern for dashboards, data analysis, or API mashups

pr()

# Global variables for callback access
currentAggregator = NULL

aggregator = new DataAggregator()
aggregator.StartAggregation()

pf()

# Global callback functions
func OnHttpSuccess(response)
    # Use currentAggregator to process the data
    # Note: We need to track which request this is for - simplified version
    currentAggregator.ProcessSourceData("API", response, 1)

func OnHttpError(error)
    ? "❌ HTTP Error: " + error
    currentAggregator.ProcessSourceData("API", NULL, 1)

# Aggaregator class
class DataAggregator
    reactive = NULL
    aggregatedData = []
    completedRequests = 0
    totalRequests = 0
    
    def Init()
       reactive = new stzReactive()
       reactive.Init()  # Initialize the reactive engine
       aggregatedData = []
       completedRequests = 0
       totalRequests = 3  # Set the expected number of requests
       currentAggregator = self  # Set global reference
        
    def StartAggregation()
        apiSources = [
            ["Users", "https://jsonplaceholder.typicode.com/users"],
            ["Posts", "https://jsonplaceholder.typicode.com/posts"],  
            ["Comments", "https://jsonplaceholder.typicode.com/comments"]
        ]
        
        ? "🔄 Starting API data aggregation..."
        ? "Fetching data from " + totalRequests + " different sources..." + NL
        
        # Fetch from all sources simultaneously (parallel requests)
        for i = 1 to len(apiSources)
            source = apiSources[i]
            name = source[1]
            url = source[2]
            
            FetchFromSource(name, url, i)
        next
        
        reactive.Start()
        
    def FetchFromSource(sourceName, sourceUrl, sourceIndex)
        ? "─> Fetching " + sourceName + " from " + sourceUrl + "..."
        
        reactive.HttpGet(sourceUrl, :OnHttpSuccess, :OnHttpError)
        
    def ProcessSourceData(sourceName, responseData, sourceIndex)
        # Simulate data processing
        if responseData != NULL
            dataSize = len(responseData)
            # Extract key metrics (simplified)
            itemCount = floor(dataSize / 100)  # Rough estimate of items
            
            result = [
                :source = sourceName,
                :status = "success",
                :itemCount = itemCount,
                :dataSize = dataSize,
                :fetchTime = clock()
            ]
            
            ? "✅ " + sourceName + " loaded: ~" + itemCount + " items (" + dataSize + " bytes)" + NL
        else
            result = [
                :source = sourceName, 
                :status = "failed",
                :itemCount = 0,
                :dataSize = 0,
                :fetchTime = clock()
            ]
            ? "⚠️  " + sourceName + " failed to load"
        ok


        aggregatedData + result
        completedRequests++
        
        # Check if all requests completed
        if completedRequests >= totalRequests
            CompleteAggregation()
        ok
        
    def CompleteAggregation()
        ? "🎉 Data aggregation completed!"
        ? "═══════════════════════════════"
        
        totalItems = 0
        totalBytes = 0
        successCount = 0
        
        for data in aggregatedData
            ? "📊 " + data[:source] + ": " + data[:status] + 
              " (" + data[:itemCount] + " items, " + data[:dataSize] + " bytes)"
              
            totalItems += data[:itemCount]
            totalBytes += data[:dataSize]
            
            if data[:status] = "success"
                successCount++
            ok
        next
        
        ? NL + "📈 SUMMARY:"
        ? "   Sources processed: " + len(aggregatedData) + "/" + totalRequests  
        ? "   Success rate: " + (successCount * 100 / totalRequests) + "%"
        ? "   Total items: ~" + totalItems
        ? "   Total data: " + totalBytes + " bytes"
        
        reactive.Stop()

#-->
# 🔄 Starting API data aggregation...
# Fetching data from 3 different sources...

# ─> Fetching Users from https://jsonplaceholder.typicode.com/users...
# ✅ API loaded: ~56 items (5645 bytes)

# ─> Fetching Posts from https://jsonplaceholder.typicode.com/posts...
# ✅ API loaded: ~275 items (27520 bytes)

# ─> Fetching Comments from https://jsonplaceholder.typicode.com/comments...
# ✅ API loaded: ~1577 items (157745 bytes)

# 🎉 Data aggregation completed!
# ═══════════════════════════════
# 📊 API: success (56 items, 5645 bytes)
# 📊 API: success (275 items, 27520 bytes)
# 📊 API: success (1577 items, 157745 bytes)

# 📈 SUMMARY:
#    Sources processed: 3/3
#    Success rate: 100%
#    Total items: ~1908
#    Total data: 190910 bytes

# Executed in 0.84 second(s) in Ring 1.23

# Executed in 0.66 second(s) in Ring 1.23

#------------------------#
#  KEY CONCEPTS SUMMARY  #
#------------------------#

/*--- What you learned with these examples:

1. **HttpGet**: Non-blocking GET requests
   - HttpGet(url, onSuccess, onError)
   - Perfect for fetching data from APIs

2. **HttpPost**: Sending data to servers
   - HttpPost(url, data, onSuccess, onError)  
   - Perfect for submitting forms, creating resources

3. **HTTP Streams**: Transform HTTP responses into reactive streams
   - Combine multiple requests into unified data flow
   - Apply transformations and filters to responses

4. **HTTP + Timers**: Polling patterns
   - SetInterval() + HttpGet() for regular data updates
   - Common pattern for real-time dashboards

5. **Parallel HTTP Requests**: Fetch multiple sources simultaneously
   - Send requests at same time, not sequentially
   - Much faster than waiting for each request

6. **Error Handling**: Always prepare for failures
   - Network issues, server errors, timeouts
   - Graceful degradation when services are unavailable

7. **Data Aggregation**: Combining results from multiple sources
   - Track completion status across multiple async operations
   - Process and summarize results when all complete

Common HTTP streaming applications:
- Real-time dashboards pulling from multiple APIs
- Social media feed aggregators  
- Stock price monitoring systems
- Weather data collectors
- News feed processors
- IoT sensor data aggregation

Best Practices:
- Always handle both success and error cases
- Use timeouts to prevent hanging requests
- Consider rate limiting when polling frequently
- Cache responses when appropriate
- Process data as it arrives (don't wait for all requests)

*/
