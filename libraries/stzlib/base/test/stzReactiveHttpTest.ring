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
# Executed in 1.10 seconds depending on network

#--------------------------------#
#  EXAMPLE 2: HTTP POST REQUEST  #
#--------------------------------#

/*--- Understanding HttpPost - Sending data to server #TODO

# HttpPost sends data to a server and receives a response
# Like filling out a form and submitting it online

pr()

# Creating and sending data via POST request

cPostData = '{
    "title": "My New Post",
    "body": "This is the content of my post", 
    "userId": 1
}'

Rs = new stzReactive()
Rs {
    ? "Sending HTTP POST request with data..." + NL

    ? "Data being sent: " + cPostData + NL
    
    # HttpPost(url, data, onSuccess_callback, onError_callback)
    HttpPost("https://jsonplaceholder.typicode.com/posts", 
        cPostData,
        func cResponse {
            ? "✅ POST SUCCESS! Server response:"
            ? "Created resource: " + cResponse
            Rs.Stop()
        },
        func cError {
            ? "❌ POST ERROR: " + cError
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
# Executed in 1.44 second(s) in Ring 1.23

#----------------------------------#
#  EXAMPLE 3: HTTP REQUEST STREAM  #
#----------------------------------#

/*--- Creating a stream of HTTP responses

# You can create streams that fetch data from multiple URLs
# Perfect for aggregating data from different sources

pr()

# List of URLs to fetch data from
aApiUrls = [
   "https://jsonplaceholder.typicode.com/posts/1",
   "https://jsonplaceholder.typicode.com/posts/2", 
   "https://jsonplaceholder.typicode.com/posts/3"
]

nCurrentIndex = 0
cRequestId = ""

Rs = new stzReactive()
Rs {
   # Create stream as property of Rs object
   Rs.httpStream = CreateStream("http-responses", "manual")
   
   # Subscribe to receive each HTTP response
   Rs.httpStream.Subscribe(func aData {
       ? " ╰─> Received from stream: Post #" + aData["id"] + " - " + 
         left(aData["title"], 30) + "..."
   })
   
   # Complete handler - called when stream ends
   Rs.httpStream.OnComplete(func() {
       ? NL + "✅ All HTTP requests completed!"
       Rs.Stop()
   })
   
   # Start fetching URLs one by one
   ? "Creating HTTP request stream for " + len(aApiUrls) + " URLs..."
   cRequestId = SetInterval(:fFetchNextUrl, 1000)  # Every 1 second
   
   Start()
}

pf()

func fFetchNextUrl()

   if nCurrentIndex < len(aApiUrls)
       nCurrentIndex++
       cUrl = aApiUrls[nCurrentIndex]
       
       ? "🔄 Fetching URL #" + nCurrentIndex + ": " + cUrl
       
       # Make the HTTP request
       Rs.HttpGet(cUrl,

           func cResponse {
               # Simulate parsing JSON response
               aMockData = [
                   :id = nCurrentIndex,
                   :title = "Post Title #" + nCurrentIndex,
                   :body = "Post body content...",
                   :response = cResponse
               ]
               
               # Emit to stream
               Rs.httpStream.Emit(aMockData)

               # Check if we're done with all URLs
               if nCurrentIndex >= len(aApiUrls)
                   Rs.ClearInterval(cRequestId)
                   Rs.httpStream.Complete()  # End the stream
               ok
           },

           func cError {
               ? "❌ Request failed: " + cError
               Rs.httpStream.EmitError(cError)
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
nPollCount = 0
nMaxPolls = 5
cPollId = ""
aDataHistory = []

Rs = new stzReactive()
Rs {
    ? "Polling server every 2 seconds for updates..." + NL
    
    # Poll every 2 seconds
    cPollId = SetInterval(:fPollServer, 2000)
    
    # Stop polling after nMaxPolls attempts
    SetTimeout(:fStopPolling, (nMaxPolls * 2000) + 500)
    
    Start()
}
pf()

func fPollServer()
    nPollCount++
    currenttime = clock()
    
    ? "Poll #" + nPollCount + " at " + currenttime + "..."
    
    # Simulate polling different endpoints or parameters
    pollUrl = "https://jsonplaceholder.typicode.com/posts/" + (nPollCount % 5 + 1)
    
    Rs.HttpGet(pollUrl,
        func cResponse {
            # Simulate extracting relevant data
            aDataPoint = [
                :poll = nPollCount,
                :timestamp = CurrentTime(),
                :hasUpdate = (nPollCount % 3 = 0),  # Simulate occasional updates
                :dataSize = len(cResponse)
            ]
            
            aDataHistory + aDataPoint
            
            if aDataPoint[:hasUpdate]
                ? "   ~> NEW DATA detected! Size: " + aDataPoint[:dataSize] + " bytes"
            else  
                ? "   ~> No changes (Size: " + aDataPoint[:dataSize] + " bytes)"
            ok
        },
        func cError {
            ? "   ❌ Poll failed: " + cError
        }
    )

func fStopPolling()
    ? NL + "⏹️  Stopping polling after " + nMaxPolls + " attempts..."
    Rs.ClearInterval(cPollId)
    
    # Summary of polling session
    ? "Polling Summary:"
    ? "  - Total polls: " + len(aDataHistory)
    nUpdates = 0
    for aData in aDataHistory
        if aData[:hasUpdate]
            nUpdates++
        ok
    next
    ? "  - Updates found: " + nUpdates
    ? "  - Success rate: " + (len(aDataHistory) * 100 / nMaxPolls) + "%"
    
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
#  EXAMPLE 5: PRACTICAL - API DATA oAggregator     #
#-------------------------------------------------#

/*--- Real-world example: Fetching and combining data from multiple APIs

# This shows how to coordinate multiple HTTP requests and combine results
# Common pattern for dashboards, data analysis, or API mashups

pr()

# Global variables for callback access
oCurrentAggregator = NULL

oAggregator = new DataAggregator()
oAggregator.StartAggregation()

pf()

# Global callback functions
func OnHttpSuccess(cResponse)
    # Use oCurrentoAggregator to process the data
    # Note: We need to track which request this is for - simplified version
    oCurrentAggregator.ProcessSourceData("API", cResponse, 1)

func OnHttpError(cError)
    ? "❌ HTTP Error: " + cError
    oCurrentoAggregator.ProcessSourceData("API", NULL, 1)

# Aggaregator class
class DataAggregator
    oReactive = NULL
    aAggregatedData = []
    nCompletedRequests = 0
    nTotalRequests = 0
    
    def Init()
       oReactive = new stzReactive()
       aAggregatedData = []
       nCompletedRequests = 0
       nTotalRequests = 3  # Set the expected number of requests
       oCurrentAggregator = self  # Set global reference
        
    def StartAggregation()
        aApiSources = [
            ["users", "https://jsonplaceholder.typicode.com/users"],
            ["posts", "https://jsonplaceholder.typicode.com/posts"],  
            ["comments", "https://jsonplaceholder.typicode.com/comments"]
        ]
        
        ? "🔄 Starting API data aggregation..."
        ? "Fetching data from " + nTotalRequests + " different sources..." + NL
        
        # Fetch from all sources simultaneously (parallel requests)
        for i = 1 to len(aApiSources)
            aSource = aApiSources[i]
            cName = aSource[1]
            cUrl = aSource[2]
            
            FetchFromSource(cName, cUrl, i)
        next
        
        oReactive.Start()
        
    def FetchFromSource(cSourceName, cSourceUrl, nSourceIndex)
        ? "─> Fetching " + cSourceName + " from " + cSourceUrl + "..."
        
        oReactive.HttpGet(cSourceUrl, :OnHttpSuccess, :OnHttpError)
        
    def ProcessSourceData(cSourceName, aResponseData, sourceIndex)
        # Simulate data processing
        if aResponseData != NULL
            nDataSize = len(aResponseData)
            # Extract key metrics (simplified)
            nItemCount = floor(nDataSize / 100)  # Rough estimate of items
            
            aResult = [
                :source = cSourceName,
                :status = "success",
                :itemCount = nItemCount,
                :dataSize = nDataSize,
                :fetchTime = clock()
            ]
            
            ? "✅ " + cSourceName + " loaded: ~" + nItemCount + " items (" + nDataSize + " bytes)" + NL
        else
            aResult = [
                :source = cSourceName, 
                :status = "failed",
                :itemCount = 0,
                :dataSize = 0,
                :fetchTime = clock()
            ]
            ? "⚠️  " +cSourceName + " failed to load"
        ok


        aAggregatedData + aResult
        nCompletedRequests++
        
        # Check if all requests completed
        if nCompletedRequests >= nTotalRequests
            CompleteAggregation()
        ok
        
    def CompleteAggregation()
        ? "🎉 Data aggregation completed!"
        ? "═══════════════════════════════"
        
        nTotalItems = 0
        nTotalBytes = 0
        nSuccessCount = 0
        
        for aData in aAggregatedData
            ? "📊 " + aData[:source] + ": " + aData[:status] + 
              " (" + aData[:itemCount] + " items, " + aData[:dataSize] + " bytes)"
              
            nTotalItems += aData[:itemCount]
            nTotalBytes += aData[:dataSize]
            
            if aData[:status] = "success"
                nSuccessCount++
            ok
        next
        
        ? NL + "📈 SUMMARY:"
        ? "   Sources processed: " + len(aAggregatedData) + "/" + ntotalRequests  
        ? "   Success rate: " + (nSuccessCount * 100 / nTotalRequests) + "%"
        ? "   Total items: ~" + nTotalItems
        ? "   Total data: " + nTotalBytes + " bytes"
        
        oReactive.Stop()

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

# Executed in 1.95 second(s) in Ring 1.23

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
- Social media feed oAggregators  
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
