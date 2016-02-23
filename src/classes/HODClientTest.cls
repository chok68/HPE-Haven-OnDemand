/**
 * Test HODClient class
 *
 * @author Topcoder
 * @version 1.0
 */
@isTest
public class HODClientTest {

    /**
     * Get API Key for the tests
     */
    private static String getAPIKeyForTest()
    {
        return '4c21b279-8916-495b-9166-74876394bcdb';
    }

    /**
     * Get API version for the tests
     */
    private static String getAPIVersion()
    {
        return 'v2';
    }

    /**
     *  ASync success test speech recognition
     */
    @isTest
    private static void testSpeechRecognition() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('url','https://test.com'));
        Map<String,Object> data = client.postRequest(params, HODAPP.SPEECH_RECOGNITION, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == '1');
        Test.stopTest();
    }

    /**
     *  ASync success test extraction
     */
    @isTest
    private static void testTextExtraction() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('test.pdf',Blob.toPdf('sample value'),'application/pdf'));
        Map<String,Object> data= client.postRequest(params, HODAPP.TEXT_EXTRACTION, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == '2');
        Test.stopTest();
    }

    /**
     *  ASync success test prediction api
     */
    @isTest
    private static void testPredictAPI() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('test.csv',Blob.valueOf('test1,test2'),'application/CSV'));
        params.add(new Param('service_name','test'));
        Map<String,Object> data = client.postRequest(params, HODAPP.PREDICT, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == '3');
        Test.stopTest();
    }

    /**
     *  ASync success test recommend api
     */
    @isTest
    private static void testRecommendAPI() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('test.csv',Blob.valueOf('test1,test2'),'application/CSV'));
        params.add(new Param('service_name','test'));
        params.add(new Param('required_label','test'));
        Map<String,Object> data= client.postRequest(params, HODAPP.RECOMMEND, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == '4');
        Test.stopTest();
    }

    /**
     *  ASync success test recommend api
     */
    @isTest
    private static void testTrainPredictionAPI() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('test.csv',Blob.valueOf('test1,test2'),'application/CSV'));
        params.add(new Param('service_name','test'));
        Map<String,Object> data= client.postRequest(params, HODAPP.TRAIN_PREDICTION, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == '5');
        Test.stopTest();
    }

    /**
     *  Sync success index status
     */
    @isTest
    private static void testIndexStatus() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // create client
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        // add parameters to be passed
        params.add(new Param('index','test'));
        // get response, it is json response
        Map<String,Object> data = client.postRequest(params, HODAPP.INDEX_STATUS, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('total_documents') == 3);
        Test.stopTest();
    }

    /**
     *  Sync success list resouces
     */
    @isTest
    private static void testListResources() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // create client
        HODClient client = new HODClient(apiKey, version);
        // set params
        List<Param> params = new List<Param>();
        params.add(new Param('flavor',new List<String>{'standard','explorer'}));
        params.add(new Param('type',new List<String>{'content','connector'}));
        // get response
        Map<String,Object> data = client.postRequest(params, HODAPP.LIST_RESOURCES, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.containsKey('private_resources'));
        Test.stopTest();
    }

    /**
     *  Sync failure index status
     */
    @isTest
    private static void testIndexStatusFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('index','test'));
        try
        {
            Map<String,Object> data= client.postRequest(params, HODAPP.INDEX_STATUS, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  Get job status
     */
    @isTest

    private static void testGetJobStatus() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        Map<String,Object> data = client.getJobStatus('1');
        System.assert(data.get(HODClientConstants.JOB_RESPONSE_STATUS) == HODClientConstants.JOB_RESPONSE_FINISHED);
        Test.stopTest();
    }

    /**
     *  Get job result speech recognition
     */
    @isTest
    private static void testGetJobResultSpeechRecognition() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        Map<String,Object> data = client.getJobResult('1');
        System.assert(data.get(HODClientConstants.JOB_ID) == '1');
        Test.stopTest();
    }

    /**
     *  Get job result text extraction
     */
    @isTest
    private static void testGetJobResultTextExtraction() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        Map<String,Object> data = client.getJobResult('2');
        System.assert(data.containsKey('document'));
        Test.stopTest();
    }

    /**
     *  Get job result predict api
     */
    @isTest
    private static void testGetJobResultPredict() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        Map<String,Object> data = client.getJobResult('3');
        System.assert(data.containsKey('file'));
        System.assert(data.get('status') == 200);
        Test.stopTest();
    }

    /**
     *  Get job result recommend api
     */
    @isTest
    private static void testGetJobResultRecommend() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        Map<String,Object> data= client.getJobResult('4');
        System.assert(data.containsKey('allRecommendations'));
        Test.stopTest();
    }

    /**
     *  Get job result train prediction api
     */
    @isTest
    private static void testGetJobResultTrainPrediction() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        Test.startTest();
        HODClient client = new HODClient(apiKey);
        Map<String,Object> data= client.getJobResult('5');
        System.assert(data.get('service') == 'my-service');
        System.assert(data.get('status') == 'Ready');
        Test.stopTest();
    }

    /**
     *  Sync failure Creates a connector. (GET)
     */
    @isTest
    private static void testCreateConnectorFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('flavor', 'sample-flavor-value'));
        params.add(new Param('connector', 'sample-connector-value'));
        params.add(new Param('config', 'sample-config-value'));
        params.add(new Param('destination', 'sample-destination-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.CREATE_CONNECTOR, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Creates a connector. (GET)
     */
    @isTest
    private static void testSyncGetCreateConnector() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('flavor', 'sample-flavor-value'));
        params.add(new Param('connector', 'sample-connector-value'));
        params.add(new Param('config', 'sample-config-value'));
        params.add(new Param('destination', 'sample-destination-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.CREATE_CONNECTOR, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('CreateConnectorKey') == 'CreateConnectorValue');
        Test.stopTest();
    }

    /**
     *  async success get test Creates a connector. (GET)
     */
    @isTest
    private static void testAsyncGetCreateConnector() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('flavor', 'sample-flavor-value'));
        params.add(new Param('connector', 'sample-connector-value'));
        params.add(new Param('config', 'sample-config-value'));
        params.add(new Param('destination', 'sample-destination-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.CREATE_CONNECTOR, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'CreateConnectorJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Starts a connector. (GET)
     */
    @isTest
    private static void testStartConnectorFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('connector', 'sample-connector-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.START_CONNECTOR, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Starts a connector. (GET)
     */
    @isTest
    private static void testSyncGetStartConnector() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('connector', 'sample-connector-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.START_CONNECTOR, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('StartConnectorKey') == 'StartConnectorValue');
        Test.stopTest();
    }

    /**
     *  async success get test Starts a connector. (GET)
     */
    @isTest
    private static void testAsyncGetStartConnector() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('connector', 'sample-connector-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.START_CONNECTOR, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'StartConnectorJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Returns connector status information. (GET)
     */
    @isTest
    private static void testConnectorStatusFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('connector', 'sample-connector-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.CONNECTOR_STATUS, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Returns connector status information. (GET)
     */
    @isTest
    private static void testSyncGetConnectorStatus() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('connector', 'sample-connector-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.CONNECTOR_STATUS, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('ConnectorStatusKey') == 'ConnectorStatusValue');
        Test.stopTest();
    }

    /**
     *  async success get test Returns connector status information. (GET)
     */
    @isTest
    private static void testAsyncGetConnectorStatus() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('connector', 'sample-connector-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.CONNECTOR_STATUS, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'ConnectorStatusJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Returns connector status history information. (GET)
     */
    @isTest
    private static void testConnectorHistoryFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.CONNECTOR_HISTORY, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Returns connector status history information. (GET)
     */
    @isTest
    private static void testSyncGetConnectorHistory() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        Map<String,Object> data = client.getRequest(params, HODAPP.CONNECTOR_HISTORY, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('ConnectorHistoryKey') == 'ConnectorHistoryValue');
        Test.stopTest();
    }

    /**
     *  async success get test Returns connector status history information. (GET)
     */
    @isTest
    private static void testAsyncGetConnectorHistory() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        Map<String,Object> data = client.getRequest(params, HODAPP.CONNECTOR_HISTORY, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'ConnectorHistoryJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Cancels a connector schedule. (GET)
     */
    @isTest
    private static void testCancelConnectorScheduleFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('connector', 'sample-connector-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.CANCEL_CONNECTOR_SCHEDULE, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Cancels a connector schedule. (GET)
     */
    @isTest
    private static void testSyncGetCancelConnectorSchedule() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('connector', 'sample-connector-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.CANCEL_CONNECTOR_SCHEDULE, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('CancelConnectorScheduleKey') == 'CancelConnectorScheduleValue');
        Test.stopTest();
    }

    /**
     *  async success get test Cancels a connector schedule. (GET)
     */
    @isTest
    private static void testAsyncGetCancelConnectorSchedule() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('connector', 'sample-connector-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.CANCEL_CONNECTOR_SCHEDULE, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'CancelConnectorScheduleJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Deletes a connector. (GET)
     */
    @isTest
    private static void testDeleteConnectorFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('connector', 'sample-connector-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.DELETE_CONNECTOR, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Deletes a connector. (GET)
     */
    @isTest
    private static void testSyncGetDeleteConnector() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('connector', 'sample-connector-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.DELETE_CONNECTOR, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('DeleteConnectorKey') == 'DeleteConnectorValue');
        Test.stopTest();
    }

    /**
     *  async success get test Deletes a connector. (GET)
     */
    @isTest
    private static void testAsyncGetDeleteConnector() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('connector', 'sample-connector-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.DELETE_CONNECTOR, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'DeleteConnectorJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Retrieves a connector configuration. (GET)
     */
    @isTest
    private static void testRetrieveConfigFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('connector', 'sample-connector-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.RETRIEVE_CONFIG, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Retrieves a connector configuration. (GET)
     */
    @isTest
    private static void testSyncGetRetrieveConfig() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('connector', 'sample-connector-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.RETRIEVE_CONFIG, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('RetrieveConfigKey') == 'RetrieveConfigValue');
        Test.stopTest();
    }

    /**
     *  async success get test Retrieves a connector configuration. (GET)
     */
    @isTest
    private static void testAsyncGetRetrieveConfig() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('connector', 'sample-connector-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.RETRIEVE_CONFIG, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'RetrieveConfigJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Updates a connector. (GET)
     */
    @isTest
    private static void testUpdateConnectorFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('connector', 'sample-connector-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.UPDATE_CONNECTOR, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Updates a connector. (GET)
     */
    @isTest
    private static void testSyncGetUpdateConnector() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('connector', 'sample-connector-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.UPDATE_CONNECTOR, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('UpdateConnectorKey') == 'UpdateConnectorValue');
        Test.stopTest();
    }

    /**
     *  async success get test Updates a connector. (GET)
     */
    @isTest
    private static void testAsyncGetUpdateConnector() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('connector', 'sample-connector-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.UPDATE_CONNECTOR, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'UpdateConnectorJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Stops a running connector. (GET)
     */
    @isTest
    private static void testStopConnectorFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('connector', 'sample-connector-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.STOP_CONNECTOR, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Stops a running connector. (GET)
     */
    @isTest
    private static void testSyncGetStopConnector() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('connector', 'sample-connector-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.STOP_CONNECTOR, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('StopConnectorKey') == 'StopConnectorValue');
        Test.stopTest();
    }

    /**
     *  async success get test Stops a running connector. (GET)
     */
    @isTest
    private static void testAsyncGetStopConnector() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('connector', 'sample-connector-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.STOP_CONNECTOR, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'StopConnectorJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Extracts text from a file. (GET)
     */
    @isTest
    private static void testTextExtractionFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('url', 'sample-url-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.TEXT_EXTRACTION, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  Sync failure Extracts the contents of a container file. (GET)
     */
    @isTest
    private static void testExpandContainerFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('url', 'sample-url-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.EXPAND_CONTAINER, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Extracts the contents of a container file. (GET)
     */
    @isTest
    private static void testSyncGetExpandContainer() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('url', 'sample-url-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.EXPAND_CONTAINER, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('ExpandContainerKey') == 'ExpandContainerValue');
        Test.stopTest();
    }

    /**
     *  async success get test Extracts the contents of a container file. (GET)
     */
    @isTest
    private static void testAsyncGetExpandContainer() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('url', 'sample-url-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.EXPAND_CONTAINER, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'ExpandContainerJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Stores a file. (GET)
     */
    @isTest
    private static void testStoreObjectFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('url', 'sample-url-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.STORE_OBJECT, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Stores a file. (GET)
     */
    @isTest
    private static void testSyncGetStoreObject() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('url', 'sample-url-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.STORE_OBJECT, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('StoreObjectKey') == 'StoreObjectValue');
        Test.stopTest();
    }

    /**
     *  async success get test Stores a file. (GET)
     */
    @isTest
    private static void testAsyncGetStoreObject() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('url', 'sample-url-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.STORE_OBJECT, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'StoreObjectJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Converts a document to HTML format for viewing in a Web browser. (GET)
     */
    @isTest
    private static void testViewDocumentFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('url', 'sample-url-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.VIEW_DOCUMENT, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Converts a document to HTML format for viewing in a Web browser. (GET)
     */
    @isTest
    private static void testSyncGetViewDocument() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('url', 'sample-url-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.VIEW_DOCUMENT, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('ViewDocumentKey') == 'ViewDocumentValue');
        Test.stopTest();
    }

    /**
     *  async success get test Converts a document to HTML format for viewing in a Web browser. (GET)
     */
    @isTest
    private static void testAsyncGetViewDocument() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('url', 'sample-url-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.VIEW_DOCUMENT, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'ViewDocumentJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Extracts text from an image. (GET)
     */
    @isTest
    private static void testOCRDocumentFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('url', 'sample-url-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.OCR_DOCUMENT, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Extracts text from an image. (GET)
     */
    @isTest
    private static void testSyncGetOCRDocument() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('url', 'sample-url-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.OCR_DOCUMENT, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('OCRDocumentKey') == 'OCRDocumentValue');
        Test.stopTest();
    }

    /**
     *  async success get test Extracts text from an image. (GET)
     */
    @isTest
    private static void testAsyncGetOCRDocument() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('url', 'sample-url-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.OCR_DOCUMENT, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'OCRDocumentJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Lists the nodes in your graph. (GET)
     */
    @isTest
    private static void testGetNodesFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.GET_NODES, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Lists the nodes in your graph. (GET)
     */
    @isTest
    private static void testSyncGetGetNodes() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        Map<String,Object> data = client.getRequest(params, HODAPP.GET_NODES, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('GetNodesKey') == 'GetNodesValue');
        Test.stopTest();
    }

    /**
     *  async success get test Lists the nodes in your graph. (GET)
     */
    @isTest
    private static void testAsyncGetGetNodes() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        Map<String,Object> data = client.getRequest(params, HODAPP.GET_NODES, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'GetNodesJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Suggests nodes that a specified node is close to in the graph, but that it does not currently connect to. (GET)
     */
    @isTest
    private static void testSuggestLinksFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.SUGGEST_LINKS, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Suggests nodes that a specified node is close to in the graph, but that it does not currently connect to. (GET)
     */
    @isTest
    private static void testSyncGetSuggestLinks() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        Map<String,Object> data = client.getRequest(params, HODAPP.SUGGEST_LINKS, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('SuggestLinksKey') == 'SuggestLinksValue');
        Test.stopTest();
    }

    /**
     *  async success get test Suggests nodes that a specified node is close to in the graph, but that it does not currently connect to. (GET)
     */
    @isTest
    private static void testAsyncGetSuggestLinks() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        Map<String,Object> data = client.getRequest(params, HODAPP.SUGGEST_LINKS, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'SuggestLinksJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Finds the shortest path in the graph between two specified nodes. (GET)
     */
    @isTest
    private static void testGetShortestPathFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('source_id', 'sample-source_id-value'));
        params.add(new Param('target_id', 'sample-target_id-value'));
        params.add(new Param('source_name', 'sample-source_name-value'));
        params.add(new Param('target_name', 'sample-target_name-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.GET_SHORTEST_PATH, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Finds the shortest path in the graph between two specified nodes. (GET)
     */
    @isTest
    private static void testSyncGetGetShortestPath() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('source_id', 'sample-source_id-value'));
        params.add(new Param('target_id', 'sample-target_id-value'));
        params.add(new Param('source_name', 'sample-source_name-value'));
        params.add(new Param('target_name', 'sample-target_name-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.GET_SHORTEST_PATH, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('GetShortestPathKey') == 'GetShortestPathValue');
        Test.stopTest();
    }

    /**
     *  async success get test Finds the shortest path in the graph between two specified nodes. (GET)
     */
    @isTest
    private static void testAsyncGetGetShortestPath() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('source_id', 'sample-source_id-value'));
        params.add(new Param('target_id', 'sample-target_id-value'));
        params.add(new Param('source_name', 'sample-source_name-value'));
        params.add(new Param('target_name', 'sample-target_name-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.GET_SHORTEST_PATH, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'GetShortestPathJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Finds the common neighbors of the nodes that you specify. (GET)
     */
    @isTest
    private static void testGetCommonNeighborsFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.GET_COMMON_NEIGHBORS, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Finds the common neighbors of the nodes that you specify. (GET)
     */
    @isTest
    private static void testSyncGetGetCommonNeighbors() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        Map<String,Object> data = client.getRequest(params, HODAPP.GET_COMMON_NEIGHBORS, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('GetCommonNeighborsKey') == 'GetCommonNeighborsValue');
        Test.stopTest();
    }

    /**
     *  async success get test Finds the common neighbors of the nodes that you specify. (GET)
     */
    @isTest
    private static void testAsyncGetGetCommonNeighbors() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        Map<String,Object> data = client.getRequest(params, HODAPP.GET_COMMON_NEIGHBORS, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'GetCommonNeighborsJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Returns a summary of what is in the graph. (GET)
     */
    @isTest
    private static void testSummarizeGraphFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.SUMMARIZE_GRAPH, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Returns a summary of what is in the graph. (GET)
     */
    @isTest
    private static void testSyncGetSummarizeGraph() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        Map<String,Object> data = client.getRequest(params, HODAPP.SUMMARIZE_GRAPH, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('SummarizeGraphKey') == 'SummarizeGraphValue');
        Test.stopTest();
    }

    /**
     *  async success get test Returns a summary of what is in the graph. (GET)
     */
    @isTest
    private static void testAsyncGetSummarizeGraph() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        Map<String,Object> data = client.getRequest(params, HODAPP.SUMMARIZE_GRAPH, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'SummarizeGraphJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Lists the neighbors of one or more specified nodes. (GET)
     */
    @isTest
    private static void testGetNeighborsFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.GET_NEIGHBORS, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Lists the neighbors of one or more specified nodes. (GET)
     */
    @isTest
    private static void testSyncGetGetNeighbors() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        Map<String,Object> data = client.getRequest(params, HODAPP.GET_NEIGHBORS, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('GetNeighborsKey') == 'GetNeighborsValue');
        Test.stopTest();
    }

    /**
     *  async success get test Lists the neighbors of one or more specified nodes. (GET)
     */
    @isTest
    private static void testAsyncGetGetNeighbors() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        Map<String,Object> data = client.getRequest(params, HODAPP.GET_NEIGHBORS, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'GetNeighborsJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Returns a subgraph based on a set of nodes that you provide. (GET)
     */
    @isTest
    private static void testGetSubgraphFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.GET_SUBGRAPH, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Returns a subgraph based on a set of nodes that you provide. (GET)
     */
    @isTest
    private static void testSyncGetGetSubgraph() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        Map<String,Object> data = client.getRequest(params, HODAPP.GET_SUBGRAPH, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('GetSubgraphKey') == 'GetSubgraphValue');
        Test.stopTest();
    }

    /**
     *  async success get test Returns a subgraph based on a set of nodes that you provide. (GET)
     */
    @isTest
    private static void testAsyncGetGetSubgraph() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        Map<String,Object> data = client.getRequest(params, HODAPP.GET_SUBGRAPH, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'GetSubgraphJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Recognizes a known set of corporate logos in an image that you provide. (GET)
     */
    @isTest
    private static void testImageRecognitionFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('url', 'sample-url-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.IMAGE_RECOGNITION, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Recognizes a known set of corporate logos in an image that you provide. (GET)
     */
    @isTest
    private static void testSyncGetImageRecognition() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('url', 'sample-url-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.IMAGE_RECOGNITION, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('ImageRecognitionKey') == 'ImageRecognitionValue');
        Test.stopTest();
    }

    /**
     *  async success get test Recognizes a known set of corporate logos in an image that you provide. (GET)
     */
    @isTest
    private static void testAsyncGetImageRecognition() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('url', 'sample-url-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.IMAGE_RECOGNITION, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'ImageRecognitionJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Detects faces in an image. (GET)
     */
    @isTest
    private static void testFaceDetectionFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('url', 'sample-url-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.FACE_DETECTION, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Detects faces in an image. (GET)
     */
    @isTest
    private static void testSyncGetFaceDetection() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('url', 'sample-url-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.FACE_DETECTION, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('FaceDetectionKey') == 'FaceDetectionValue');
        Test.stopTest();
    }

    /**
     *  async success get test Detects faces in an image. (GET)
     */
    @isTest
    private static void testAsyncGetFaceDetection() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('url', 'sample-url-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.FACE_DETECTION, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'FaceDetectionJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Detects and decodes 1D and 2D barcodes in an image that you provide. (GET)
     */
    @isTest
    private static void testBarcodeRecognitionFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('url', 'sample-url-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.BARCODE_RECOGNITION, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Detects and decodes 1D and 2D barcodes in an image that you provide. (GET)
     */
    @isTest
    private static void testSyncGetBarcodeRecognition() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('url', 'sample-url-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.BARCODE_RECOGNITION, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('BarcodeRecognitionKey') == 'BarcodeRecognitionValue');
        Test.stopTest();
    }

    /**
     *  async success get test Detects and decodes 1D and 2D barcodes in an image that you provide. (GET)
     */
    @isTest
    private static void testAsyncGetBarcodeRecognition() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('url', 'sample-url-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.BARCODE_RECOGNITION, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'BarcodeRecognitionJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Creates objects that support document classification. (GET)
     */
    @isTest
    private static void testCreateClassificationFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('type', 'sample-type-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.CREATE_CLASSIFICATION, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Creates objects that support document classification. (GET)
     */
    @isTest
    private static void testSyncGetCreateClassification() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('type', 'sample-type-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.CREATE_CLASSIFICATION, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('CreateClassificationKey') == 'CreateClassificationValue');
        Test.stopTest();
    }

    /**
     *  async success get test Creates objects that support document classification. (GET)
     */
    @isTest
    private static void testAsyncGetCreateClassification() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('type', 'sample-type-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.CREATE_CLASSIFICATION, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'CreateClassificationJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Creates policies or policy types. (GET)
     */
    @isTest
    private static void testCreatePolicyFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('name', 'sample-name-value'));
        params.add(new Param('type', 'sample-type-value'));
        params.add(new Param('additional', 'sample-additional-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.CREATE_POLICY, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Creates policies or policy types. (GET)
     */
    @isTest
    private static void testSyncGetCreatePolicy() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('name', 'sample-name-value'));
        params.add(new Param('type', 'sample-type-value'));
        params.add(new Param('additional', 'sample-additional-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.CREATE_POLICY, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('CreatePolicyKey') == 'CreatePolicyValue');
        Test.stopTest();
    }

    /**
     *  async success get test Creates policies or policy types. (GET)
     */
    @isTest
    private static void testAsyncGetCreatePolicy() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('name', 'sample-name-value'));
        params.add(new Param('type', 'sample-type-value'));
        params.add(new Param('additional', 'sample-additional-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.CREATE_POLICY, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'CreatePolicyJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Deletes objects that support document classification. (GET)
     */
    @isTest
    private static void testDeleteClassificationFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('id', 'sample-id-value'));
        params.add(new Param('type', 'sample-type-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.DELETE_CLASSIFICATION, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Deletes objects that support document classification. (GET)
     */
    @isTest
    private static void testSyncGetDeleteClassification() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('id', 'sample-id-value'));
        params.add(new Param('type', 'sample-type-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.DELETE_CLASSIFICATION, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('DeleteClassificationKey') == 'DeleteClassificationValue');
        Test.stopTest();
    }

    /**
     *  async success get test Deletes objects that support document classification. (GET)
     */
    @isTest
    private static void testAsyncGetDeleteClassification() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('id', 'sample-id-value'));
        params.add(new Param('type', 'sample-type-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.DELETE_CLASSIFICATION, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'DeleteClassificationJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Deletes policies or policy types. (GET)
     */
    @isTest
    private static void testDeletePolicyFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('id', 'sample-id-value'));
        params.add(new Param('type', 'sample-type-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.DELETE_POLICY, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Deletes policies or policy types. (GET)
     */
    @isTest
    private static void testSyncGetDeletePolicy() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('id', 'sample-id-value'));
        params.add(new Param('type', 'sample-type-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.DELETE_POLICY, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('DeletePolicyKey') == 'DeletePolicyValue');
        Test.stopTest();
    }

    /**
     *  async success get test Deletes policies or policy types. (GET)
     */
    @isTest
    private static void testAsyncGetDeletePolicy() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('id', 'sample-id-value'));
        params.add(new Param('type', 'sample-type-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.DELETE_POLICY, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'DeletePolicyJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Retrieves policies or policy types. (GET)
     */
    @isTest
    private static void testRetrievePolicyFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('type', 'sample-type-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.RETRIEVE_POLICY, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Retrieves policies or policy types. (GET)
     */
    @isTest
    private static void testSyncGetRetrievePolicy() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('type', 'sample-type-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.RETRIEVE_POLICY, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('RetrievePolicyKey') == 'RetrievePolicyValue');
        Test.stopTest();
    }

    /**
     *  async success get test Retrieves policies or policy types. (GET)
     */
    @isTest
    private static void testAsyncGetRetrievePolicy() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('type', 'sample-type-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.RETRIEVE_POLICY, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'RetrievePolicyJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Updates objects that support document classification. (GET)
     */
    @isTest
    private static void testUpdateClassificationFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('type', 'sample-type-value'));
        params.add(new Param('id', 'sample-id-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.UPDATE_CLASSIFICATION, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Updates objects that support document classification. (GET)
     */
    @isTest
    private static void testSyncGetUpdateClassification() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('type', 'sample-type-value'));
        params.add(new Param('id', 'sample-id-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.UPDATE_CLASSIFICATION, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('UpdateClassificationKey') == 'UpdateClassificationValue');
        Test.stopTest();
    }

    /**
     *  async success get test Updates objects that support document classification. (GET)
     */
    @isTest
    private static void testAsyncGetUpdateClassification() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('type', 'sample-type-value'));
        params.add(new Param('id', 'sample-id-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.UPDATE_CLASSIFICATION, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'UpdateClassificationJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Retrieves objects that support document classification. (GET)
     */
    @isTest
    private static void testRetrieveClassificationFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('type', 'sample-type-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.RETRIEVE_CLASSIFICATION, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Retrieves objects that support document classification. (GET)
     */
    @isTest
    private static void testSyncGetRetrieveClassification() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('type', 'sample-type-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.RETRIEVE_CLASSIFICATION, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('RetrieveClassificationKey') == 'RetrieveClassificationValue');
        Test.stopTest();
    }

    /**
     *  async success get test Retrieves objects that support document classification. (GET)
     */
    @isTest
    private static void testAsyncGetRetrieveClassification() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('type', 'sample-type-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.RETRIEVE_CLASSIFICATION, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'RetrieveClassificationJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Updates policies or policy types. (GET)
     */
    @isTest
    private static void testUpdatePolicyFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('id', 'sample-id-value'));
        params.add(new Param('name', 'sample-name-value'));
        params.add(new Param('type', 'sample-type-value'));
        params.add(new Param('additional', 'sample-additional-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.UPDATE_POLICY, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Updates policies or policy types. (GET)
     */
    @isTest
    private static void testSyncGetUpdatePolicy() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('id', 'sample-id-value'));
        params.add(new Param('name', 'sample-name-value'));
        params.add(new Param('type', 'sample-type-value'));
        params.add(new Param('additional', 'sample-additional-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.UPDATE_POLICY, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('UpdatePolicyKey') == 'UpdatePolicyValue');
        Test.stopTest();
    }

    /**
     *  async success get test Updates policies or policy types. (GET)
     */
    @isTest
    private static void testAsyncGetUpdatePolicy() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('id', 'sample-id-value'));
        params.add(new Param('name', 'sample-name-value'));
        params.add(new Param('type', 'sample-type-value'));
        params.add(new Param('additional', 'sample-additional-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.UPDATE_POLICY, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'UpdatePolicyJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Deletes a query profile. (GET)
     */
    @isTest
    private static void testDeleteQueryProfileFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('query_profile', 'sample-query_profile-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.DELETE_QUERY_PROFILE, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Deletes a query profile. (GET)
     */
    @isTest
    private static void testSyncGetDeleteQueryProfile() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('query_profile', 'sample-query_profile-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.DELETE_QUERY_PROFILE, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('DeleteQueryProfileKey') == 'DeleteQueryProfileValue');
        Test.stopTest();
    }

    /**
     *  async success get test Deletes a query profile. (GET)
     */
    @isTest
    private static void testAsyncGetDeleteQueryProfile() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('query_profile', 'sample-query_profile-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.DELETE_QUERY_PROFILE, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'DeleteQueryProfileJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Retrieves a query profile. (GET)
     */
    @isTest
    private static void testRetrieveQueryProfileFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('query_profile', 'sample-query_profile-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.RETRIEVE_QUERY_PROFILE, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Retrieves a query profile. (GET)
     */
    @isTest
    private static void testSyncGetRetrieveQueryProfile() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('query_profile', 'sample-query_profile-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.RETRIEVE_QUERY_PROFILE, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('RetrieveQueryProfileKey') == 'RetrieveQueryProfileValue');
        Test.stopTest();
    }

    /**
     *  async success get test Retrieves a query profile. (GET)
     */
    @isTest
    private static void testAsyncGetRetrieveQueryProfile() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('query_profile', 'sample-query_profile-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.RETRIEVE_QUERY_PROFILE, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'RetrieveQueryProfileJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Creates a query profile. (GET)
     */
    @isTest
    private static void testCreateQueryProfileFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('query_profile', 'sample-query_profile-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.CREATE_QUERY_PROFILE, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Creates a query profile. (GET)
     */
    @isTest
    private static void testSyncGetCreateQueryProfile() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('query_profile', 'sample-query_profile-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.CREATE_QUERY_PROFILE, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('CreateQueryProfileKey') == 'CreateQueryProfileValue');
        Test.stopTest();
    }

    /**
     *  async success get test Creates a query profile. (GET)
     */
    @isTest
    private static void testAsyncGetCreateQueryProfile() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('query_profile', 'sample-query_profile-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.CREATE_QUERY_PROFILE, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'CreateQueryProfileJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Updates a query profile. (GET)
     */
    @isTest
    private static void testUpdateQueryProfileFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('query_profile', 'sample-query_profile-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.UPDATE_QUERY_PROFILE, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Updates a query profile. (GET)
     */
    @isTest
    private static void testSyncGetUpdateQueryProfile() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('query_profile', 'sample-query_profile-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.UPDATE_QUERY_PROFILE, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('UpdateQueryProfileKey') == 'UpdateQueryProfileValue');
        Test.stopTest();
    }

    /**
     *  async success get test Updates a query profile. (GET)
     */
    @isTest
    private static void testAsyncGetUpdateQueryProfile() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('query_profile', 'sample-query_profile-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.UPDATE_QUERY_PROFILE, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'UpdateQueryProfileJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Displays the content of one or more specified documents or document sections. (GET)
     */
    @isTest
    private static void testGetContentFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('index_reference', 'sample-index_reference-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.GET_CONTENT, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Displays the content of one or more specified documents or document sections. (GET)
     */
    @isTest
    private static void testSyncGetGetContent() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('index_reference', 'sample-index_reference-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.GET_CONTENT, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('GetContentKey') == 'GetContentValue');
        Test.stopTest();
    }

    /**
     *  async success get test Displays the content of one or more specified documents or document sections. (GET)
     */
    @isTest
    private static void testAsyncGetGetContent() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('index_reference', 'sample-index_reference-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.GET_CONTENT, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'GetContentJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Returns the best terms and phrases in documents that match the specified query. (GET)
     */
    @isTest
    private static void testFindRelatedConceptsFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('text', 'sample-text-value'));
        params.add(new Param('url', 'sample-url-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.FIND_RELATED_CONCEPTS, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Returns the best terms and phrases in documents that match the specified query. (GET)
     */
    @isTest
    private static void testSyncGetFindRelatedConcepts() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('text', 'sample-text-value'));
        params.add(new Param('url', 'sample-url-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.FIND_RELATED_CONCEPTS, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('FindRelatedConceptsKey') == 'FindRelatedConceptsValue');
        Test.stopTest();
    }

    /**
     *  async success get test Returns the best terms and phrases in documents that match the specified query. (GET)
     */
    @isTest
    private static void testAsyncGetFindRelatedConcepts() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('text', 'sample-text-value'));
        params.add(new Param('url', 'sample-url-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.FIND_RELATED_CONCEPTS, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'FindRelatedConceptsJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Retrieves the ingested fields for a specified field type or for all field types. (GET)
     */
    @isTest
    private static void testRetrieveIndexFieldsFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.RETRIEVE_INDEX_FIELDS, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Retrieves the ingested fields for a specified field type or for all field types. (GET)
     */
    @isTest
    private static void testSyncGetRetrieveIndexFields() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        Map<String,Object> data = client.getRequest(params, HODAPP.RETRIEVE_INDEX_FIELDS, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('RetrieveIndexFieldsKey') == 'RetrieveIndexFieldsValue');
        Test.stopTest();
    }

    /**
     *  async success get test Retrieves the ingested fields for a specified field type or for all field types. (GET)
     */
    @isTest
    private static void testAsyncGetRetrieveIndexFields() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        Map<String,Object> data = client.getRequest(params, HODAPP.RETRIEVE_INDEX_FIELDS, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'RetrieveIndexFieldsJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Searches for items that match your specified natural language text, Boolean expressions, or fields. (GET)
     */
    @isTest
    private static void testQueryTextIndexFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('text', 'sample-text-value'));
        params.add(new Param('url', 'sample-url-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.QUERY_TEXT_INDEX, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Searches for items that match your specified natural language text, Boolean expressions, or fields. (GET)
     */
    @isTest
    private static void testSyncGetQueryTextIndex() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('text', 'sample-text-value'));
        params.add(new Param('url', 'sample-url-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.QUERY_TEXT_INDEX, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('QueryTextIndexKey') == 'QueryTextIndexValue');
        Test.stopTest();
    }

    /**
     *  async success get test Searches for items that match your specified natural language text, Boolean expressions, or fields. (GET)
     */
    @isTest
    private static void testAsyncGetQueryTextIndex() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('text', 'sample-text-value'));
        params.add(new Param('url', 'sample-url-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.QUERY_TEXT_INDEX, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'QueryTextIndexJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Performs parametric search that combines query text with one or more parametric field names. (GET)
     */
    @isTest
    private static void testGetParametricValuesFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('field_name', 'sample-field_name-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.GET_PARAMETRIC_VALUES, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Performs parametric search that combines query text with one or more parametric field names. (GET)
     */
    @isTest
    private static void testSyncGetGetParametricValues() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('field_name', 'sample-field_name-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.GET_PARAMETRIC_VALUES, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('GetParametricValuesKey') == 'GetParametricValuesValue');
        Test.stopTest();
    }

    /**
     *  async success get test Performs parametric search that combines query text with one or more parametric field names. (GET)
     */
    @isTest
    private static void testAsyncGetGetParametricValues() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('field_name', 'sample-field_name-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.GET_PARAMETRIC_VALUES, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'GetParametricValuesJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Finds documents that are conceptually similar to your text or a document. (GET)
     */
    @isTest
    private static void testFindSimilarFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('index_reference', 'sample-index_reference-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('text', 'sample-text-value'));
        params.add(new Param('url', 'sample-url-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.FIND_SIMILAR, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Finds documents that are conceptually similar to your text or a document. (GET)
     */
    @isTest
    private static void testSyncGetFindSimilar() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('index_reference', 'sample-index_reference-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('text', 'sample-text-value'));
        params.add(new Param('url', 'sample-url-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.FIND_SIMILAR, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('FindSimilarKey') == 'FindSimilarValue');
        Test.stopTest();
    }

    /**
     *  async success get test Finds documents that are conceptually similar to your text or a document. (GET)
     */
    @isTest
    private static void testAsyncGetFindSimilar() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('index_reference', 'sample-index_reference-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('text', 'sample-text-value'));
        params.add(new Param('url', 'sample-url-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.FIND_SIMILAR, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'FindSimilarJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Completes a word fragment. (GET)
     */
    @isTest
    private static void testAutoCompleteFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('text', 'sample-text-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.AUTO_COMPLETE, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Completes a word fragment. (GET)
     */
    @isTest
    private static void testSyncGetAutoComplete() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('text', 'sample-text-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.AUTO_COMPLETE, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('AutoCompleteKey') == 'AutoCompleteValue');
        Test.stopTest();
    }

    /**
     *  async success get test Completes a word fragment. (GET)
     */
    @isTest
    private static void testAsyncGetAutoComplete() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('text', 'sample-text-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.AUTO_COMPLETE, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'AutoCompleteJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Extracts the key concepts from the text you submit. (GET)
     */
    @isTest
    private static void testConceptExtractionFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('text', 'sample-text-value'));
        params.add(new Param('url', 'sample-url-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.CONCEPT_EXTRACTION, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Extracts the key concepts from the text you submit. (GET)
     */
    @isTest
    private static void testSyncGetConceptExtraction() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('text', 'sample-text-value'));
        params.add(new Param('url', 'sample-url-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.CONCEPT_EXTRACTION, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('ConceptExtractionKey') == 'ConceptExtractionValue');
        Test.stopTest();
    }

    /**
     *  async success get test Extracts the key concepts from the text you submit. (GET)
     */
    @isTest
    private static void testAsyncGetConceptExtraction() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('text', 'sample-text-value'));
        params.add(new Param('url', 'sample-url-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.CONCEPT_EXTRACTION, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'ConceptExtractionJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Classifies a document into predefined collections. (GET)
     */
    @isTest
    private static void testClassifyDocumentFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('json', 'sample-json-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('url', 'sample-url-value'));
        params.add(new Param('collection_sequence', 'sample-collection_sequence-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.CLASSIFY_DOCUMENT, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Classifies a document into predefined collections. (GET)
     */
    @isTest
    private static void testSyncGetClassifyDocument() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('json', 'sample-json-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('url', 'sample-url-value'));
        params.add(new Param('collection_sequence', 'sample-collection_sequence-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.CLASSIFY_DOCUMENT, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('ClassifyDocumentKey') == 'ClassifyDocumentValue');
        Test.stopTest();
    }

    /**
     *  async success get test Classifies a document into predefined collections. (GET)
     */
    @isTest
    private static void testAsyncGetClassifyDocument() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('json', 'sample-json-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('url', 'sample-url-value'));
        params.add(new Param('collection_sequence', 'sample-collection_sequence-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.CLASSIFY_DOCUMENT, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'ClassifyDocumentJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Extracts entities (words, phrases, or blocks of information) from your input text. (GET)
     */
    @isTest
    private static void testEntityExtractionFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('text', 'sample-text-value'));
        params.add(new Param('url', 'sample-url-value'));
        params.add(new Param('entity_type', 'sample-entity_type-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.ENTITY_EXTRACTION, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Extracts entities (words, phrases, or blocks of information) from your input text. (GET)
     */
    @isTest
    private static void testSyncGetEntityExtraction() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('text', 'sample-text-value'));
        params.add(new Param('url', 'sample-url-value'));
        params.add(new Param('entity_type', 'sample-entity_type-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.ENTITY_EXTRACTION, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('EntityExtractionKey') == 'EntityExtractionValue');
        Test.stopTest();
    }

    /**
     *  async success get test Extracts entities (words, phrases, or blocks of information) from your input text. (GET)
     */
    @isTest
    private static void testAsyncGetEntityExtraction() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('text', 'sample-text-value'));
        params.add(new Param('url', 'sample-url-value'));
        params.add(new Param('entity_type', 'sample-entity_type-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.ENTITY_EXTRACTION, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'EntityExtractionJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Returns a list of matching possible terms for a wildcard, stem, or fuzzy expansion. (GET)
     */
    @isTest
    private static void testExpandTermsFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('text', 'sample-text-value'));
        params.add(new Param('url', 'sample-url-value'));
        params.add(new Param('expansion', 'sample-expansion-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.EXPAND_TERMS, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Returns a list of matching possible terms for a wildcard, stem, or fuzzy expansion. (GET)
     */
    @isTest
    private static void testSyncGetExpandTerms() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('text', 'sample-text-value'));
        params.add(new Param('url', 'sample-url-value'));
        params.add(new Param('expansion', 'sample-expansion-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.EXPAND_TERMS, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('ExpandTermsKey') == 'ExpandTermsValue');
        Test.stopTest();
    }

    /**
     *  async success get test Returns a list of matching possible terms for a wildcard, stem, or fuzzy expansion. (GET)
     */
    @isTest
    private static void testAsyncGetExpandTerms() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('text', 'sample-text-value'));
        params.add(new Param('url', 'sample-url-value'));
        params.add(new Param('expansion', 'sample-expansion-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.EXPAND_TERMS, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'ExpandTermsJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Identifies the language of a piece of text. (GET)
     */
    @isTest
    private static void testLanguageIdentificationFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('text', 'sample-text-value'));
        params.add(new Param('url', 'sample-url-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.LANGUAGE_IDENTIFICATION, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Identifies the language of a piece of text. (GET)
     */
    @isTest
    private static void testSyncGetLanguageIdentification() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('text', 'sample-text-value'));
        params.add(new Param('url', 'sample-url-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.LANGUAGE_IDENTIFICATION, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('LanguageIdentificationKey') == 'LanguageIdentificationValue');
        Test.stopTest();
    }

    /**
     *  async success get test Identifies the language of a piece of text. (GET)
     */
    @isTest
    private static void testAsyncGetLanguageIdentification() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('text', 'sample-text-value'));
        params.add(new Param('url', 'sample-url-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.LANGUAGE_IDENTIFICATION, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'LanguageIdentificationJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Highlights the specified terms in the text you submit. (GET)
     */
    @isTest
    private static void testHighlightTextFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('text', 'sample-text-value'));
        params.add(new Param('url', 'sample-url-value'));
        params.add(new Param('highlight_expression', 'sample-highlight_expression-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.HIGHLIGHT_TEXT, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Highlights the specified terms in the text you submit. (GET)
     */
    @isTest
    private static void testSyncGetHighlightText() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('text', 'sample-text-value'));
        params.add(new Param('url', 'sample-url-value'));
        params.add(new Param('highlight_expression', 'sample-highlight_expression-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.HIGHLIGHT_TEXT, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('HighlightTextKey') == 'HighlightTextValue');
        Test.stopTest();
    }

    /**
     *  async success get test Highlights the specified terms in the text you submit. (GET)
     */
    @isTest
    private static void testAsyncGetHighlightText() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('text', 'sample-text-value'));
        params.add(new Param('url', 'sample-url-value'));
        params.add(new Param('highlight_expression', 'sample-highlight_expression-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.HIGHLIGHT_TEXT, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'HighlightTextJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Analyzes text for positive or negative sentiment. (GET)
     */
    @isTest
    private static void testSentimentAnalysisFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('text', 'sample-text-value'));
        params.add(new Param('url', 'sample-url-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.SENTIMENT_ANALYSIS, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Analyzes text for positive or negative sentiment. (GET)
     */
    @isTest
    private static void testSyncGetSentimentAnalysis() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('text', 'sample-text-value'));
        params.add(new Param('url', 'sample-url-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.SENTIMENT_ANALYSIS, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('SentimentAnalysisKey') == 'SentimentAnalysisValue');
        Test.stopTest();
    }

    /**
     *  async success get test Analyzes text for positive or negative sentiment. (GET)
     */
    @isTest
    private static void testAsyncGetSentimentAnalysis() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('text', 'sample-text-value'));
        params.add(new Param('url', 'sample-url-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.SENTIMENT_ANALYSIS, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'SentimentAnalysisJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Searches for categories that match a specified document. (GET)
     */
    @isTest
    private static void testDocumentCategorizationFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('json', 'sample-json-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('text', 'sample-text-value'));
        params.add(new Param('url', 'sample-url-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.DOCUMENT_CATEGORIZATION, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Searches for categories that match a specified document. (GET)
     */
    @isTest
    private static void testSyncGetDocumentCategorization() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('json', 'sample-json-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('text', 'sample-text-value'));
        params.add(new Param('url', 'sample-url-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.DOCUMENT_CATEGORIZATION, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('DocumentCategorizationKey') == 'DocumentCategorizationValue');
        Test.stopTest();
    }

    /**
     *  async success get test Searches for categories that match a specified document. (GET)
     */
    @isTest
    private static void testAsyncGetDocumentCategorization() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('json', 'sample-json-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('text', 'sample-text-value'));
        params.add(new Param('url', 'sample-url-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.DOCUMENT_CATEGORIZATION, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'DocumentCategorizationJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Returns information about the terms in the specified text. (GET)
     */
    @isTest
    private static void testTextTokenizationFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('text', 'sample-text-value'));
        params.add(new Param('url', 'sample-url-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.TEXT_TOKENIZATION, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Returns information about the terms in the specified text. (GET)
     */
    @isTest
    private static void testSyncGetTextTokenization() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('text', 'sample-text-value'));
        params.add(new Param('url', 'sample-url-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.TEXT_TOKENIZATION, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('TextTokenizationKey') == 'TextTokenizationValue');
        Test.stopTest();
    }

    /**
     *  async success get test Returns information about the terms in the specified text. (GET)
     */
    @isTest
    private static void testAsyncGetTextTokenization() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('text', 'sample-text-value'));
        params.add(new Param('url', 'sample-url-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.TEXT_TOKENIZATION, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'TextTokenizationJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Creates a text index. (GET)
     */
    @isTest
    private static void testCreateTextIndexFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('index', 'sample-index-value'));
        params.add(new Param('flavor', 'sample-flavor-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.CREATE_TEXT_INDEX, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Creates a text index. (GET)
     */
    @isTest
    private static void testSyncGetCreateTextIndex() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('index', 'sample-index-value'));
        params.add(new Param('flavor', 'sample-flavor-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.CREATE_TEXT_INDEX, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('CreateTextIndexKey') == 'CreateTextIndexValue');
        Test.stopTest();
    }

    /**
     *  async success get test Creates a text index. (GET)
     */
    @isTest
    private static void testAsyncGetCreateTextIndex() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('index', 'sample-index-value'));
        params.add(new Param('flavor', 'sample-flavor-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.CREATE_TEXT_INDEX, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'CreateTextIndexJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Deletes a text index. (GET)
     */
    @isTest
    private static void testDeleteTextIndexFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('index', 'sample-index-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.DELETE_TEXT_INDEX, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Deletes a text index. (GET)
     */
    @isTest
    private static void testSyncGetDeleteTextIndex() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('index', 'sample-index-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.DELETE_TEXT_INDEX, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('DeleteTextIndexKey') == 'DeleteTextIndexValue');
        Test.stopTest();
    }

    /**
     *  async success get test Deletes a text index. (GET)
     */
    @isTest
    private static void testAsyncGetDeleteTextIndex() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('index', 'sample-index-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.DELETE_TEXT_INDEX, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'DeleteTextIndexJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Indexes a document. (GET)
     */
    @isTest
    private static void testAddtoTextIndexFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('json', 'sample-json-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('url', 'sample-url-value'));
        params.add(new Param('index', 'sample-index-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.ADD_TO_TEXT_INDEX, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Indexes a document. (GET)
     */
    @isTest
    private static void testSyncGetAddtoTextIndex() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('json', 'sample-json-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('url', 'sample-url-value'));
        params.add(new Param('index', 'sample-index-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.ADD_TO_TEXT_INDEX, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('AddtoTextIndexKey') == 'AddtoTextIndexValue');
        Test.stopTest();
    }

    /**
     *  async success get test Indexes a document. (GET)
     */
    @isTest
    private static void testAsyncGetAddtoTextIndex() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('file', 'sample-file-value'));
        params.add(new Param('json', 'sample-json-value'));
        params.add(new Param('reference', 'sample-reference-value'));
        params.add(new Param('url', 'sample-url-value'));
        params.add(new Param('index', 'sample-index-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.ADD_TO_TEXT_INDEX, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'AddtoTextIndexJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Restores a text index at a previous state. (GET)
     */
    @isTest
    private static void testRestoreTextIndexFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('index', 'sample-index-value'));
        params.add(new Param('new_index', 'sample-new_index-value'));
        params.add(new Param('date', 'sample-date-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.RESTORE_TEXT_INDEX, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Restores a text index at a previous state. (GET)
     */
    @isTest
    private static void testSyncGetRestoreTextIndex() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('index', 'sample-index-value'));
        params.add(new Param('new_index', 'sample-new_index-value'));
        params.add(new Param('date', 'sample-date-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.RESTORE_TEXT_INDEX, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('RestoreTextIndexKey') == 'RestoreTextIndexValue');
        Test.stopTest();
    }

    /**
     *  async success get test Restores a text index at a previous state. (GET)
     */
    @isTest
    private static void testAsyncGetRestoreTextIndex() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('index', 'sample-index-value'));
        params.add(new Param('new_index', 'sample-new_index-value'));
        params.add(new Param('date', 'sample-date-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.RESTORE_TEXT_INDEX, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'RestoreTextIndexJobID');
        Test.stopTest();
    }

    /**
     *  Sync failure Deletes a document from the index. (GET)
     */
    @isTest
    private static void testDeletefromTextIndexFailure() {
        testSetup(false);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('index', 'sample-index-value'));
        try
        {
            Map<String,Object> data= client.getRequest(params, HODAPP.DELETE_FROM_TEXT_INDEX, HODClientConstants.REQ_MODE.SYNC);
        }
        catch(HODClientException ex)
        {
             String response = ex.getMessage();
             System.assert(response.contains('4004'));
        }
        Test.stopTest();
    }

    /**
     *  sync success get test Deletes a document from the index. (GET)
     */
    @isTest
    private static void testSyncGetDeletefromTextIndex() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('index', 'sample-index-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.DELETE_FROM_TEXT_INDEX, HODClientConstants.REQ_MODE.SYNC);
        System.assert(data.get('DeletefromTextIndexKey') == 'DeletefromTextIndexValue');
        Test.stopTest();
    }

    /**
     *  async success get test Deletes a document from the index. (GET)
     */
    @isTest
    private static void testAsyncGetDeletefromTextIndex() {
        testSetup(true);
        String apiKey = getAPIKeyForTest();
        String version = getAPIVersion();
        Test.startTest();
        // with apikey and version
        HODClient client = new HODClient(apiKey, version);
        List<Param> params = new List<Param>();
        params.add(new Param('index', 'sample-index-value'));
        Map<String,Object> data = client.getRequest(params, HODAPP.DELETE_FROM_TEXT_INDEX, HODClientConstants.REQ_MODE.ASYNC);
        System.assert(data.get(HODClientConstants.JOB_ID) == 'DeletefromTextIndexJobID');
        Test.stopTest();
    }

    // sets the mock service
    // if false : then error mock service is binded
    // if true : then success mock service is binded
    private static void testSetup(Boolean successful) {
        // set mock callout class implementing the HttpCalloutMock Interface
        if (successful) {
            // set successful response mock
            Test.setMock(HttpCalloutMock.class, new HODClientTestHelper.MockIDOLSuccessResponseGenerator());
        } else {
            // set failure response mock
            Test.setMock(HttpCalloutMock.class, new HODClientTestHelper.MockIDOLFailureResponseGenerator());
        }
    }
}