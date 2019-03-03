module TrailGuide
  module Adapters
    module Participants
      class Cookie
        include Canfig::Instance

        # TODO maybe be a little better about checking for action dispatch, etc.?

        class << self
          alias_method :configure, :new
          def new(context, **opts, &block)
            configure(&block).new(context, **opts)
          end
        end

        def initialize(&block)
          configure do |config|
            config.cookie = :trailguide
            config.path = '/'
            config.expiration = 1.year.to_i
            # TODO other cookie options (domain, ssl, etc.)

            yield(config) if block_given?
          end
        end

        # instance method, creates a new adapter and passes through config
        def new(context)
          raise NoMethodError, "Your current context (#{context}) does not support cookies" unless context.respond_to?(:cookies, true)
          Adapter.new(context, configuration)
        end

        class Adapter
          attr_reader :context, :config

          def initialize(context, config)
            @context = context
            @config = config
          end

          def [](key)
            cookie[key.to_s]
          end

          def []=(key, value)
            cookie.merge!({key.to_s => value})
            write_cookie
          end

          def delete(key)
            cookie.tap { |h| h.delete(key.to_s) }
            write_cookie
          end

          def keys
            cookie.keys
          end

          def key?(key)
            cookie.key?(key)
          end

          def to_h
            cookie.to_h
          end

          private

          def cookie
            @cookie ||= begin
              JSON.parse(cookies[config.cookie.to_s])
            rescue
              {}
            end
          end

          def cookies
            context.send(:cookies)
          end

          def write_cookie
            cookies[config.cookie.to_s] = cookie_options.merge({value: cookie.as_json})
          end

          def cookie_options
            {
              expires: Time.now + config.expiration,
              path: config.path
            }
          end
        end
      end
    end
  end
end