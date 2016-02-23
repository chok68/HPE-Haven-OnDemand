/**
 * Helper methods for HODClientTest cases
 *
 * @version 1.0
 * @author Topcoder
 */

@isTest
public class HODClientTestHelper {

    /**
     * Success Mock class for API Tests
     *
     */
    public class MockIDOLSuccessResponseGenerator implements HttpCalloutMock {
        public HttpResponse respond(HTTPRequest req) {
            // Create a mock response
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setStatusCode(200);
            if (req.getEndpoint().contains(HODApp.SPEECH_RECOGNITION)) {
                // speech recognition async
                res.setBody('{"jobID":"1"}');
            }
            else if (req.getEndpoint().contains(HODApp.TEXT_EXTRACTION)) {
                // text extraction async
                res.setBody('{"jobID":"2"}');
            }
            else if (req.getEndpoint().contains(HODApp.PREDICT)) {
                // predict async
                res.setBody('{"jobID":"3"}');
            }
            else if (req.getEndpoint().contains(HODApp.RECOMMEND)) {
                // recommend async
                res.setBody('{"jobID":"4"}');
            }
            else if (req.getEndpoint().contains(HODApp.TRAIN_PREDICTION)) {
                // train prediction async
                res.setBody('{"jobID":"5"}');
            }
            else if (req.getEndpoint().contains(HODApp.INDEX_STATUS)) {
                // index status sync
                res.setBody(responseIndexStatus);
            }
            else if (req.getEndpoint().contains(HODApp.LIST_RESOURCES)) {
                // list resources
                res.setBody(responseListResources);
            }
            else if (req.getEndpoint().contains(HODApp.CREATE_CONNECTOR)) {
                // Creates a connector.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"CreateConnectorJobID"}');
                }
                else {
                    res.setBody(responseCreateConnector);
                }
            }
            else if (req.getEndpoint().contains(HODApp.START_CONNECTOR)) {
                // Starts a connector.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"StartConnectorJobID"}');
                }
                else {
                    res.setBody(responseStartConnector);
                }
            }
            else if (req.getEndpoint().contains(HODApp.CONNECTOR_STATUS)) {
                // Returns connector status information.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"ConnectorStatusJobID"}');
                }
                else {
                    res.setBody(responseConnectorStatus);
                }
            }
            else if (req.getEndpoint().contains(HODApp.CONNECTOR_HISTORY)) {
                // Returns connector status history information.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"ConnectorHistoryJobID"}');
                }
                else {
                    res.setBody(responseConnectorHistory);
                }
            }
            else if (req.getEndpoint().contains(HODApp.CANCEL_CONNECTOR_SCHEDULE)) {
                // Cancels a connector schedule.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"CancelConnectorScheduleJobID"}');
                }
                else {
                    res.setBody(responseCancelConnectorSchedule);
                }
            }
            else if (req.getEndpoint().contains(HODApp.DELETE_CONNECTOR)) {
                // Deletes a connector.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"DeleteConnectorJobID"}');
                }
                else {
                    res.setBody(responseDeleteConnector);
                }
            }
            else if (req.getEndpoint().contains(HODApp.RETRIEVE_CONFIG)) {
                // Retrieves a connector configuration.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"RetrieveConfigJobID"}');
                }
                else {
                    res.setBody(responseRetrieveConfig);
                }
            }
            else if (req.getEndpoint().contains(HODApp.UPDATE_CONNECTOR)) {
                // Updates a connector.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"UpdateConnectorJobID"}');
                }
                else {
                    res.setBody(responseUpdateConnector);
                }
            }
            else if (req.getEndpoint().contains(HODApp.STOP_CONNECTOR)) {
                // Stops a running connector.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"StopConnectorJobID"}');
                }
                else {
                    res.setBody(responseStopConnector);
                }
            }
            else if (req.getEndpoint().contains(HODApp.EXPAND_CONTAINER)) {
                // Extracts the contents of a container file.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"ExpandContainerJobID"}');
                }
                else {
                    res.setBody(responseExpandContainer);
                }
            }
            else if (req.getEndpoint().contains(HODApp.STORE_OBJECT)) {
                // Stores a file.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"StoreObjectJobID"}');
                }
                else {
                    res.setBody(responseStoreObject);
                }
            }
            else if (req.getEndpoint().contains(HODApp.VIEW_DOCUMENT)) {
                // Converts a document to HTML format for viewing in a Web browser.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"ViewDocumentJobID"}');
                }
                else {
                    res.setBody(responseViewDocument);
                }
            }
            else if (req.getEndpoint().contains(HODApp.OCR_DOCUMENT)) {
                // Extracts text from an image.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"OCRDocumentJobID"}');
                }
                else {
                    res.setBody(responseOCRDocument);
                }
            }
            else if (req.getEndpoint().contains(HODApp.GET_NODES)) {
                // Lists the nodes in your graph.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"GetNodesJobID"}');
                }
                else {
                    res.setBody(responseGetNodes);
                }
            }
            else if (req.getEndpoint().contains(HODApp.SUGGEST_LINKS)) {
                // Suggests nodes that a specified node is close to in the graph, but that it does not currently connect to.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"SuggestLinksJobID"}');
                }
                else {
                    res.setBody(responseSuggestLinks);
                }
            }
            else if (req.getEndpoint().contains(HODApp.GET_SHORTEST_PATH)) {
                // Finds the shortest path in the graph between two specified nodes.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"GetShortestPathJobID"}');
                }
                else {
                    res.setBody(responseGetShortestPath);
                }
            }
            else if (req.getEndpoint().contains(HODApp.GET_COMMON_NEIGHBORS)) {
                // Lists the neighbors of one or more specified nodes.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"GetCommonNeighborsJobID"}');
                }
                else {
                    res.setBody(responseGetCommonNeighbors);
                }
            }
            else if (req.getEndpoint().contains(HODApp.SUMMARIZE_GRAPH)) {
                // Returns a summary of what is in the graph.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"SummarizeGraphJobID"}');
                }
                else {
                    res.setBody(responseSummarizeGraph);
                }
            }
            else if (req.getEndpoint().contains(HODApp.GET_NEIGHBORS)) {
                // Lists the neighbors of one or more specified nodes.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"GetNeighborsJobID"}');
                }
                else {
                    res.setBody(responseGetNeighbors);
                }
            }
            else if (req.getEndpoint().contains(HODApp.GET_SUBGRAPH)) {
                // Returns a subgraph based on a set of nodes that you provide.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"GetSubgraphJobID"}');
                }
                else {
                    res.setBody(responseGetSubgraph);
                }
            }
            else if (req.getEndpoint().contains(HODApp.IMAGE_RECOGNITION)) {
                // Recognizes a known set of corporate logos in an image that you provide.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"ImageRecognitionJobID"}');
                }
                else {
                    res.setBody(responseImageRecognition);
                }
            }
            else if (req.getEndpoint().contains(HODApp.FACE_DETECTION)) {
                // Detects faces in an image.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"FaceDetectionJobID"}');
                }
                else {
                    res.setBody(responseFaceDetection);
                }
            }
            else if (req.getEndpoint().contains(HODApp.BARCODE_RECOGNITION)) {
                // Detects and decodes 1D and 2D barcodes in an image that you provide.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"BarcodeRecognitionJobID"}');
                }
                else {
                    res.setBody(responseBarcodeRecognition);
                }
            }
            else if (req.getEndpoint().contains(HODApp.CREATE_CLASSIFICATION)) {
                // Creates objects that support document classification.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"CreateClassificationJobID"}');
                }
                else {
                    res.setBody(responseCreateClassification);
                }
            }
            else if (req.getEndpoint().contains(HODApp.CREATE_POLICY)) {
                // Creates policies or policy types.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"CreatePolicyJobID"}');
                }
                else {
                    res.setBody(responseCreatePolicy);
                }
            }
            else if (req.getEndpoint().contains(HODApp.DELETE_CLASSIFICATION)) {
                // Deletes objects that support document classification.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"DeleteClassificationJobID"}');
                }
                else {
                    res.setBody(responseDeleteClassification);
                }
            }
            else if (req.getEndpoint().contains(HODApp.DELETE_POLICY)) {
                // Deletes policies or policy types.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"DeletePolicyJobID"}');
                }
                else {
                    res.setBody(responseDeletePolicy);
                }
            }
            else if (req.getEndpoint().contains(HODApp.RETRIEVE_POLICY)) {
                // Retrieves policies or policy types.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"RetrievePolicyJobID"}');
                }
                else {
                    res.setBody(responseRetrievePolicy);
                }
            }
            else if (req.getEndpoint().contains(HODApp.UPDATE_CLASSIFICATION)) {
                // Updates objects that support document classification.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"UpdateClassificationJobID"}');
                }
                else {
                    res.setBody(responseUpdateClassification);
                }
            }
            else if (req.getEndpoint().contains(HODApp.RETRIEVE_CLASSIFICATION)) {
                // Retrieves objects that support document classification.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"RetrieveClassificationJobID"}');
                }
                else {
                    res.setBody(responseRetrieveClassification);
                }
            }
            else if (req.getEndpoint().contains(HODApp.UPDATE_POLICY)) {
                // Updates policies or policy types.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"UpdatePolicyJobID"}');
                }
                else {
                    res.setBody(responseUpdatePolicy);
                }
            }
            else if (req.getEndpoint().contains(HODApp.DELETE_QUERY_PROFILE)) {
                // Deletes a query profile.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"DeleteQueryProfileJobID"}');
                }
                else {
                    res.setBody(responseDeleteQueryProfile);
                }
            }
            else if (req.getEndpoint().contains(HODApp.RETRIEVE_QUERY_PROFILE)) {
                // Retrieves a query profile.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"RetrieveQueryProfileJobID"}');
                }
                else {
                    res.setBody(responseRetrieveQueryProfile);
                }
            }
            else if (req.getEndpoint().contains(HODApp.CREATE_QUERY_PROFILE)) {
                // Creates a query profile.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"CreateQueryProfileJobID"}');
                }
                else {
                    res.setBody(responseCreateQueryProfile);
                }
            }
            else if (req.getEndpoint().contains(HODApp.UPDATE_QUERY_PROFILE)) {
                // Updates a query profile.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"UpdateQueryProfileJobID"}');
                }
                else {
                    res.setBody(responseUpdateQueryProfile);
                }
            }
            else if (req.getEndpoint().contains(HODApp.GET_CONTENT)) {
                // Displays the content of one or more specified documents or document sections.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"GetContentJobID"}');
                }
                else {
                    res.setBody(responseGetContent);
                }
            }
            else if (req.getEndpoint().contains(HODApp.FIND_RELATED_CONCEPTS)) {
                // Returns the best terms and phrases in documents that match the specified query.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"FindRelatedConceptsJobID"}');
                }
                else {
                    res.setBody(responseFindRelatedConcepts);
                }
            }
            else if (req.getEndpoint().contains(HODApp.RETRIEVE_INDEX_FIELDS)) {
                // Retrieves the ingested fields for a specified field type or for all field types.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"RetrieveIndexFieldsJobID"}');
                }
                else {
                    res.setBody(responseRetrieveIndexFields);
                }
            }
            else if (req.getEndpoint().contains(HODApp.QUERY_TEXT_INDEX)) {
                // Searches for items that match your specified natural language text, Boolean expressions, or fields.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"QueryTextIndexJobID"}');
                }
                else {
                    res.setBody(responseQueryTextIndex);
                }
            }
            else if (req.getEndpoint().contains(HODApp.GET_PARAMETRIC_VALUES)) {
                // Performs parametric search that combines query text with one or more parametric field names.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"GetParametricValuesJobID"}');
                }
                else {
                    res.setBody(responseGetParametricValues);
                }
            }
            else if (req.getEndpoint().contains(HODApp.FIND_SIMILAR)) {
                // Finds documents that are conceptually similar to your text or a document.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"FindSimilarJobID"}');
                }
                else {
                    res.setBody(responseFindSimilar);
                }
            }
            else if (req.getEndpoint().contains(HODApp.AUTO_COMPLETE)) {
                // Completes a word fragment.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"AutoCompleteJobID"}');
                }
                else {
                    res.setBody(responseAutoComplete);
                }
            }
            else if (req.getEndpoint().contains(HODApp.CONCEPT_EXTRACTION)) {
                // Extracts the key concepts from the text you submit.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"ConceptExtractionJobID"}');
                }
                else {
                    res.setBody(responseConceptExtraction);
                }
            }
            else if (req.getEndpoint().contains(HODApp.CLASSIFY_DOCUMENT)) {
                // Classifies a document into predefined collections.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"ClassifyDocumentJobID"}');
                }
                else {
                    res.setBody(responseClassifyDocument);
                }
            }
            else if (req.getEndpoint().contains(HODApp.ENTITY_EXTRACTION)) {
                // Extracts entities (words, phrases, or blocks of information) from your input text.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"EntityExtractionJobID"}');
                }
                else {
                    res.setBody(responseEntityExtraction);
                }
            }
            else if (req.getEndpoint().contains(HODApp.EXPAND_TERMS)) {
                // Returns a list of matching possible terms for a wildcard, stem, or fuzzy expansion.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"ExpandTermsJobID"}');
                }
                else {
                    res.setBody(responseExpandTerms);
                }
            }
            else if (req.getEndpoint().contains(HODApp.LANGUAGE_IDENTIFICATION)) {
                // Identifies the language of a piece of text.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"LanguageIdentificationJobID"}');
                }
                else {
                    res.setBody(responseLanguageIdentification);
                }
            }
            else if (req.getEndpoint().contains(HODApp.HIGHLIGHT_TEXT)) {
                // Highlights the specified terms in the text you submit.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"HighlightTextJobID"}');
                }
                else {
                    res.setBody(responseHighlightText);
                }
            }
            else if (req.getEndpoint().contains(HODApp.SENTIMENT_ANALYSIS)) {
                // Analyzes text for positive or negative sentiment.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"SentimentAnalysisJobID"}');
                }
                else {
                    res.setBody(responseSentimentAnalysis);
                }
            }
            else if (req.getEndpoint().contains(HODApp.DOCUMENT_CATEGORIZATION)) {
                // Searches for categories that match a specified document.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"DocumentCategorizationJobID"}');
                }
                else {
                    res.setBody(responseDocumentCategorization);
                }
            }
            else if (req.getEndpoint().contains(HODApp.TEXT_TOKENIZATION)) {
                // Returns information about the terms in the specified text.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"TextTokenizationJobID"}');
                }
                else {
                    res.setBody(responseTextTokenization);
                }
            }
            else if (req.getEndpoint().contains(HODApp.CREATE_TEXT_INDEX)) {
                // Creates a text index.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"CreateTextIndexJobID"}');
                }
                else {
                    res.setBody(responseCreateTextIndex);
                }
            }
            else if (req.getEndpoint().contains(HODApp.DELETE_TEXT_INDEX)) {
                // Deletes a text index.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"DeleteTextIndexJobID"}');
                }
                else {
                    res.setBody(responseDeleteTextIndex);
                }
            }
            else if (req.getEndpoint().contains(HODApp.ADD_TO_TEXT_INDEX)) {
                // Indexes a document.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"AddtoTextIndexJobID"}');
                }
                else {
                    res.setBody(responseAddtoTextIndex);
                }
            }
            else if (req.getEndpoint().contains(HODApp.RESTORE_TEXT_INDEX)) {
                // Restores a text index at a previous state.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"RestoreTextIndexJobID"}');
                }
                else {
                    res.setBody(responseRestoreTextIndex);
                }
            }
            else if (req.getEndpoint().contains(HODApp.DELETE_FROM_TEXT_INDEX)) {
                // Deletes a document from the index.
                if (req.getEndPoint().contains('async'))
                {
                    res.setBody('{"jobID":"DeletefromTextIndexJobID"}');
                }
                else {
                    res.setBody(responseDeletefromTextIndex);
                }
            }
            else if (req.getEndpoint().contains(HODClientConstants.JOB_STATUS)) {
                // call job status
                res.setBody(responseStatus);
            }
            else if (req.getEndpoint().contains(HODClientConstants.JOB_RESULT)) {
                List<String> url = req.getEndpoint().split('\\?');
                String removeQueryParams = url.get(0);
                // call job result
                List<String> data = removeQueryParams.split('/');
                String jobId = data.get(data.size()-1);
                res.setBody(asyncJobData.get(jobId));
            }
            return res;
        }
    }

    /**
     * Failure Mock class for API Tests
     *
     */
    public class MockIDOLFailureResponseGenerator implements HttpCalloutMock {
        public HttpResponse respond(HTTPRequest req) {
            // Create a mock response
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setStatusCode(400);
            // for the sake of simplicity, use single failure message
            res.setBody(responseFailure);
            return res;
        }
    }

    //  ------- successful responses ---------------//
    public static final String responseSpeechRecognition = '{"actions":[{"result":{"document":[{"content":"I guess thatit"}]},"status":"finished","action":"recognizespeech","version":"v1"}],"jobID":"1","status":"finished"}';
    public static final String responseTextExtraction = '{"document":[{"reference":"TextExtraction.docx","doc_iod_reference":"b41d1c8ed299a9ce5f6a913817643397","app_name":["Microsoft Office Word"],"app_version":["15.0000"],"author":["Virender"],"characters_with_spaces":["1301"],"char_count":["1109"],"code_page":["65001"],"content_type":["application/x-ms-word07"],"created_date":["1453906680"],"document_attributes":["0"],"file_size":[13430],"edit_time":["0"],"hyperlinks_changed":["0"],"last_author":["Virender"],"modified_date":[1453906680],"line_count":["9"],"links_dirty":["0"],"page_count":["1"],"par_count":["2"],"rev_number":["2"],"scale_crop":["0"],"security":["0"],"shared_doc":["0"],"template":["Normal.dotm"],"word_count":["194"],"content":"this is test."}],"md5sum":["1f817dd5c24f1623ebdc95ae71f794d3"]}';
    public Static final String responseTrainPrediction = '{"service":"my-service","status":"Ready"}';
    public Static final String responseRecomendation = '{"allRecommendations":[{"originalValues":[{}],"recommendations":[{"recommendation":[{}],"distance":"1.4142135623730951","confidence":"1.0","new_prediction":"class0"},{}]}],"fields":[{}]}';
    public static final String responsePredict = '{"status":200,"file":"age,workclass,fnlwgt,education,education-num,marital-status,occupation,relationship,race,sex,capital-gain"}';
    public static final String responseStatus = '{"status":"finished"}';
    public static final String responseIndexStatus = '{"total_documents": 3,"total_index_size": 1335,"24hr_index_updates": 0,"component_count": 1}';
    public static final String responseListResources = '{"public_resources":[],"private_resources":[{"resource":"test","type":"content","flavor":"standard","description":null,"date_created":"Fri Jan 08 2016 10:32:46 GMT+0000 (UTC)","display_name":null,"resourceUUID":"7b40cca0-bca7-4976-ad5c-1c4ab5313adb"}]}';
    public static final String responseCreateConnector = '{"CreateConnectorKey": "CreateConnectorValue"}';
    public static final String responseStartConnector = '{"StartConnectorKey": "StartConnectorValue"}';
    public static final String responseConnectorStatus = '{"ConnectorStatusKey": "ConnectorStatusValue"}';
    public static final String responseConnectorHistory = '{"ConnectorHistoryKey": "ConnectorHistoryValue"}';
    public static final String responseCancelConnectorSchedule = '{"CancelConnectorScheduleKey": "CancelConnectorScheduleValue"}';
    public static final String responseDeleteConnector = '{"DeleteConnectorKey": "DeleteConnectorValue"}';
    public static final String responseRetrieveConfig = '{"RetrieveConfigKey": "RetrieveConfigValue"}';
    public static final String responseUpdateConnector = '{"UpdateConnectorKey": "UpdateConnectorValue"}';
    public static final String responseStopConnector = '{"StopConnectorKey": "StopConnectorValue"}';
    public static final String responseExpandContainer = '{"ExpandContainerKey": "ExpandContainerValue"}';
    public static final String responseStoreObject = '{"StoreObjectKey": "StoreObjectValue"}';
    public static final String responseViewDocument = '{"ViewDocumentKey": "ViewDocumentValue"}';
    public static final String responseOCRDocument = '{"OCRDocumentKey": "OCRDocumentValue"}';
    public static final String responseGetNodes = '{"GetNodesKey": "GetNodesValue"}';
    public static final String responseSuggestLinks = '{"SuggestLinksKey": "SuggestLinksValue"}';
    public static final String responseGetShortestPath = '{"GetShortestPathKey": "GetShortestPathValue"}';
    public static final String responseGetCommonNeighbors = '{"GetCommonNeighborsKey": "GetCommonNeighborsValue"}';
    public static final String responseSummarizeGraph = '{"SummarizeGraphKey": "SummarizeGraphValue"}';
    public static final String responseGetNeighbors = '{"GetNeighborsKey": "GetNeighborsValue"}';
    public static final String responseGetSubgraph = '{"GetSubgraphKey": "GetSubgraphValue"}';
    public static final String responseFaceDetection = '{"FaceDetectionKey": "FaceDetectionValue"}';
    public static final String responseImageRecognition = '{"ImageRecognitionKey": "ImageRecognitionValue"}';
    public static final String responseBarcodeRecognition = '{"BarcodeRecognitionKey": "BarcodeRecognitionValue"}';
    public static final String responseCreateClassification = '{"CreateClassificationKey": "CreateClassificationValue"}';
    public static final String responseCreatePolicy = '{"CreatePolicyKey": "CreatePolicyValue"}';
    public static final String responseDeleteClassification = '{"DeleteClassificationKey": "DeleteClassificationValue"}';
    public static final String responseDeletePolicy = '{"DeletePolicyKey": "DeletePolicyValue"}';
    public static final String responseRetrievePolicy = '{"RetrievePolicyKey": "RetrievePolicyValue"}';
    public static final String responseUpdateClassification = '{"UpdateClassificationKey": "UpdateClassificationValue"}';
    public static final String responseRetrieveClassification = '{"RetrieveClassificationKey": "RetrieveClassificationValue"}';
    public static final String responseUpdatePolicy = '{"UpdatePolicyKey": "UpdatePolicyValue"}';
    public static final String responseDeleteQueryProfile = '{"DeleteQueryProfileKey": "DeleteQueryProfileValue"}';
    public static final String responseRetrieveQueryProfile = '{"RetrieveQueryProfileKey": "RetrieveQueryProfileValue"}';
    public static final String responseCreateQueryProfile = '{"CreateQueryProfileKey": "CreateQueryProfileValue"}';
    public static final String responseUpdateQueryProfile = '{"UpdateQueryProfileKey": "UpdateQueryProfileValue"}';
    public static final String responseGetContent = '{"GetContentKey": "GetContentValue"}';
    public static final String responseFindRelatedConcepts = '{"FindRelatedConceptsKey": "FindRelatedConceptsValue"}';
    public static final String responseRetrieveIndexFields = '{"RetrieveIndexFieldsKey": "RetrieveIndexFieldsValue"}';
    public static final String responseQueryTextIndex = '{"QueryTextIndexKey": "QueryTextIndexValue"}';
    public static final String responseGetParametricValues = '{"GetParametricValuesKey": "GetParametricValuesValue"}';
    public static final String responseFindSimilar = '{"FindSimilarKey": "FindSimilarValue"}';
    public static final String responseRecommend = '{"RecommendKey": "RecommendValue"}';
    public static final String responseAutoComplete = '{"AutoCompleteKey": "AutoCompleteValue"}';
    public static final String responseConceptExtraction = '{"ConceptExtractionKey": "ConceptExtractionValue"}';
    public static final String responseClassifyDocument = '{"ClassifyDocumentKey": "ClassifyDocumentValue"}';
    public static final String responseEntityExtraction = '{"EntityExtractionKey": "EntityExtractionValue"}';
    public static final String responseExpandTerms = '{"ExpandTermsKey": "ExpandTermsValue"}';
    public static final String responseLanguageIdentification = '{"LanguageIdentificationKey": "LanguageIdentificationValue"}';
    public static final String responseHighlightText = '{"HighlightTextKey": "HighlightTextValue"}';
    public static final String responseSentimentAnalysis = '{"SentimentAnalysisKey": "SentimentAnalysisValue"}';
    public static final String responseDocumentCategorization = '{"DocumentCategorizationKey": "DocumentCategorizationValue"}';
    public static final String responseTextTokenization = '{"TextTokenizationKey": "TextTokenizationValue"}';
    public static final String responseCreateTextIndex = '{"CreateTextIndexKey": "CreateTextIndexValue"}';
    public static final String responseAddtoTextIndex = '{"AddtoTextIndexKey": "AddtoTextIndexValue"}';
    public static final String responseDeletefromTextIndex = '{"DeletefromTextIndexKey": "DeletefromTextIndexValue"}';
    public static final String responseRestoreTextIndex = '{"RestoreTextIndexKey": "RestoreTextIndexValue"}';
    public static final String responseDeleteTextIndex = '{"DeleteTextIndexKey": "DeleteTextIndexValue"}';

    // error response
    public static final String responseFailure = '{"error": 4004,"reason": "Invalid job action","detail": { "message": "API not found"}}';

    // job id :  response mapping
    public static Map<String, String> asyncJobData = new Map<String,String>
    {
        '1'=>responseSpeechRecognition,
        '2'=>responseTextExtraction,
        '3'=>responsePredict,
        '4'=>responseRecomendation,
        '5'=>responseTrainPrediction
     };
}