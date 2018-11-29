require 'active_support'
require 'active_support/core_ext/string'

guard :rspec, cmd: "bundle exec rspec" do
  require "guard/rspec/dsl"
  dsl = Guard::RSpec::Dsl.new(self)

  # Feel free to open issues for suggestions and improvements

  # RSpec files
  rspec = dsl.rspec
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { rspec.spec_dir }
  watch(rspec.spec_files)

  # Ruby files
  ruby = dsl.ruby
  dsl.watch_spec_files_for(ruby.lib_files)

  # Rails files
  rails = dsl.rails
  dsl.watch_spec_files_for(rails.app_files)

  watch(rails.controllers) do |m|
    [
      rspec.spec.call("routing/#{m[1]}_routing"),
      rspec.spec.call("controllers/#{m[1]}_controller"),
      "#{rspec.spec_dir}/api/v1/#{m[1]}"
    ]
  end

  # Rails config changes
  watch(rails.spec_helper)     { rspec.spec_dir }
  watch(rails.routes)          { "#{rspec.spec_dir}/routing" }
  watch(rails.app_controller)  { "#{rspec.spec_dir}/controllers" }

  api_spec = lambda do |m|
    "#{rspec.spec_dir}/api/v1/#{m[1].pluralize}"
  end

  watch %r{^app/resources/(.+)_resource\.rb$} do |m|
    [
      api_spec.call(m),
      "#{rspec.spec_dir}/resources/#{m[1]}"
    ]
  end

  watch(%r{^app/models/(.+)\.rb$}, &api_spec)
  watch(%r{^app/serializers/serializable_(.+)\.rb$}, &api_spec)
end

if `uname` =~ /Darwin/
  notification :terminal_notifier
else
  growl_host = ENV.fetch('GROWL_HOST', '127.0.0.1')
  growl_port = ENV.fetch('GROWL_PORT', 23053)

  begin
    require 'socket'

    socket = TCPSocket.open(growl_host, growl_port)
    socket.close
    notification :gntp, host: growl_host, port: growl_port
  rescue SocketError, Errno::ECONNREFUSED => e
    Guard::UI.logger.warn "Could not connect to growl host at #{growl_host}:#{growl_port}"
    notification :off
  end
end
