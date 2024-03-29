/**
 * generic HTTP client to send HTTP request to the endpoint
 * and receive HTTP response from the endpoint
 *
 * @version 1.0
 * @author Topcoder
 */
public  class HttpClient {    
    /**
     * calls POST Request
     *
     * @param url Url of the endpoint , it should contain query string
     * @param payLoad pay load to be transferred in body
     * @return HttpResponse response 
     */  
    public static HttpResponse postRequest(String url, String payLoad)
    {
        try
        {
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint(url);
            req.setTimeout(HODClientConstants.TIME_OUT);
            req.setMethod(HODClientConstants.POST_REQUEST);
            // check for payload
            if(payLoad.length() != 0)
            {
                // set headers if body is passed
                req.setHeader('Content-Type','multipart/form-data; boundary='+HODClientConstants.BOUNDARY_MULTIPART);
                req.setHeader('Content-Length',String.valueof(payLoad.length()));
                req.setBody(payLoad);
            }
            else
            {
                req.setHeader('Accept', 'application/json');
                req.setHeader('Content-Type', 'application/json');
            }
            HttpResponse resp = h.send(req);
            return resp;
        }
        catch(Exception ex)
        {
            Map<String,String> exceptionData = new Map<String,String>();
            // throw error
            throw new HODClientException(ex.getMessage());
        }
    }

    /**
     * calls GET Request
     *
     * @param url Url of the endpoint , it should contain query string
     * @return HttpResponse response 
     */  
    public static HttpResponse getRequest(String url)
    {
        try
        {
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint(url);
            req.setTimeout(HODClientConstants.TIME_OUT);
            req.setMethod(HODClientConstants.GET_REQUEST);
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            HttpResponse resp = h.send(req);
            return resp;
        }
        catch(Exception ex)
        {
            Map<String,String> exceptionData = new Map<String,String>();
            // throw error
            throw new HODClientException(ex.getMessage());
        }
    }
}