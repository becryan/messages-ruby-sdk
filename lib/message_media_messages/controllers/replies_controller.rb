# This file was automatically generated for MessageMedia by APIMATIC v2.0
# ( https://apimatic.io ).

module MessageMediaMessages
  # RepliesController
  # noinspection RubyResolve,RubyInstanceMethodNamingConvention,RubyStringKeysInHashInspection
  class RepliesController < BaseController
    @instance = RepliesController.new

    class << self
      attr_accessor :instance
    end

    def instance
      self.class.instance
    end

    # Mark a reply message as confirmed so it is no longer returned in check
    # replies requests.
    # The confirm replies endpoint is intended to be used in conjunction with
    # the check replies endpoint
    # to allow for robust processing of reply messages. Once one or more reply
    # messages have been processed
    # they can then be confirmed using the confirm replies endpoint so they are
    # no longer returned in
    # subsequent check replies requests.
    # The confirm replies endpoint takes a list of reply IDs as follows:
    # ```json
    # {
    #     "reply_ids": [
    #         "011dcead-6988-4ad6-a1c7-6b6c68ea628d",
    #         "3487b3fa-6586-4979-a233-2d1b095c7718",
    #         "ba28e94b-c83d-4759-98e7-ff9c7edb87a1"
    #     ]
    # }
    # ```
    # Up to 100 replies can be confirmed in a single confirm replies request.
    # @param [ConfirmRepliesAsReceivedRequest] body Required parameter:
    # Example:
    # @param [Object] account_header_value The account id to pass to the API
    # @return Mixed response from the API call
    def create_confirm_replies_as_received(body, account_header_value=nil)
      begin
        @logger.info("create_confirm_replies_as_received called.")
        
        request_url = '/v1/replies/confirmed'
        
        # Prepare query url.
        @logger.info("Preparing query URL for create_confirm_replies_as_received.")
        query_builder = Configuration.base_uri.dup
        query_builder << request_url
        query_url = APIHelper.clean_url query_builder
  
        # Prepare headers.
        @logger.info("Preparing headers for create_confirm_replies_as_received.")
        headers = {
          'accept' => 'application/json',
          'content-type' => 'application/json; charset=utf-8'
        }

        add_account_header(headers, account_header_value)

        json_body = body.to_json

        # Prepare and execute HttpRequest.
        @logger.info('Preparing and executing HttpRequest for create_confirm_replies_as_received.')
        request = @http_client.post(
          query_url,
          headers: headers,
          parameters: json_body
        )

        apply_authentication(request, request_url, json_body)

        context = execute_request(request, name: 'create_confirm_replies_as_received')
  
        # Validate response against endpoint and global error codes.
        @logger.info("Validating response for create_confirm_replies_as_received.")
        if context.response.status_code == 400
          raise APIException.new(
            '',
            context
          )
        end
        validate_response(context)
  
        # Return appropriate response type.
        @logger.info("Returning response for create_confirm_replies_as_received.")
        return APIHelper.json_deserialize(context.response.raw_body) unless
                context.response.raw_body.nil? ||
                context.response.raw_body.to_s.strip.empty?

      rescue Exception => e
        @logger.error(e)
        raise e
      end
    end

    # Check for any replies that have been received.
    # Replies are messages that have been sent from a handset in response to a
    # message sent by an
    # application or messages that have been sent from a handset to a inbound
    # number associated with
    # an account, known as a dedicated inbound number (contact
    # <support@messagemedia.com> for more
    # information on dedicated inbound numbers).
    # Each request to the check replies endpoint will return any replies
    # received that have not yet
    # been confirmed using the confirm replies endpoint. A response from the
    # check replies endpoint
    # will have the following structure:
    # ```json
    # {
    #     "replies": [
    #         {
    #             "metadata": {
    #                 "key1": "value1",
    #                 "key2": "value2"
    #             },
    #             "message_id": "877c19ef-fa2e-4cec-827a-e1df9b5509f7",
    #             "reply_id": "a175e797-2b54-468b-9850-41a3eab32f74",
    #             "date_received": "2016-12-07T08:43:00.850Z",
    #             "callback_url": "https://my.callback.url.com",
    #             "destination_number": "+61491570156",
    #             "source_number": "+61491570157",
    #             "vendor_account_id": {
    #                 "vendor_id": "MessageMedia",
    #                 "account_id": "MyAccount"
    #             },
    #             "content": "My first reply!"
    #         },
    #         {
    #             "metadata": {
    #                 "key1": "value1",
    #                 "key2": "value2"
    #             },
    #             "message_id": "8f2f5927-2e16-4f1c-bd43-47dbe2a77ae4",
    #             "reply_id": "3d8d53d8-01d3-45dd-8cfa-4dfc81600f7f",
    #             "date_received": "2016-12-07T08:43:00.850Z",
    #             "callback_url": "https://my.callback.url.com",
    #             "destination_number": "+61491570157",
    #             "source_number": "+61491570158",
    #             "vendor_account_id": {
    #                 "vendor_id": "MessageMedia",
    #                 "account_id": "MyAccount"
    #             },
    #             "content": "My second reply!"
    #         }
    #     ]
    # }
    # ```
    # Each reply will contain details about the reply message, as well as
    # details of the message the reply was sent
    # in response to, including any metadata specified. Every reply will have a
    # reply ID to be used with the
    # confirm replies endpoint.
    # *Note: The source number and destination number properties in a reply are
    # the inverse of those
    # specified in the message the reply is in response to. The source number of
    # the reply message is the
    # same as the destination number of the original message, and the
    # destination number of the reply
    # message is the same as the source number of the original message. If a
    # source number
    # wasn't specified in the original message, then the destination number
    # property will not be present
    # in the reply message.*
    # Subsequent requests to the check replies endpoint will return the same
    # reply messages and a maximum
    # of 100 replies will be returned in each request. Applications should use
    # the confirm replies endpoint
    # in the following pattern so that replies that have been processed are no
    # longer returned in
    # subsequent check replies requests.
    # 1. Call check replies endpoint
    # 2. Process each reply message
    # 3. Confirm all processed reply messages using the confirm replies endpoint
    # *Note: It is recommended to use the Webhooks feature to receive reply
    # messages rather than polling
    # the check replies endpoint.*
    # @param [Object] account_header_value The account id to pass to the API
    # @return CheckRepliesResponse response from the API call
    def get_check_replies(account_header_value=nil)
      begin
        @logger.info("get_check_replies called.")
        
        request_url = '/v1/replies'
        # Prepare query url.
        @logger.info("Preparing query URL for get_check_replies.")
        query_builder = Configuration.base_uri.dup
        query_builder << request_url
        query_url = APIHelper.clean_url query_builder
  
        # Prepare headers.
        @logger.info("Preparing headers for get_check_replies.")
        headers = {
          'accept' => 'application/json'
        }

        add_account_header(headers, account_header_value)

        # Prepare and execute HttpRequest.
        @logger.info('Preparing and executing HttpRequest for get_check_replies.')
        request = @http_client.get(
          query_url,
          headers: headers
        )

        apply_authentication(request, request_url)

        context = execute_request(request, name: 'get_check_replies')
        validate_response(context)
  
        # Return appropriate response type.
        @logger.info("Returning response for get_check_replies.")
        decoded = APIHelper.json_deserialize(context.response.raw_body)
        CheckRepliesResponse.from_hash(decoded)

      rescue Exception => e
        @logger.error(e)
        raise e
      end
    end
  end
end
