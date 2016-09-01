require "googleauth"
require "grpc"
require "google/datastore/v1/datastore_services_pb"

# Get the environment configured authorization
scopes = ["https://www.googleapis.com/auth/datastore"]
authorization = Google::Auth.get_application_default scopes

host = "datastore.googleapis.com"
call_credentials = GRPC::Core::CallCredentials.new authorization.updater_proc
channel_credentials = GRPC::Core::ChannelCredentials.new.compose call_credentials
@project = ENV["GRPC_REPRO_PROJECT"] || "nodal-almanac-725"
@stub = Google::Datastore::V1::Datastore::Stub.new host, channel_credentials

def print_output
  puts "Starting the process to call GRPC..."

  lookup_key = Google::Datastore::V1::Key.new(
    path: [Google::Datastore::V1::Key::PathElement.new(kind: "Person", name: "blowmage")])
  puts "The key we are going to lookup is #{lookup_key}"

  lookup_req = Google::Datastore::V1::LookupRequest.new(
    project_id: @project,
    keys: [lookup_key]
  )
  puts "The lookup request we are going to make is #{lookup_req}"

  puts "The stub we are going to use is #{@stub}"

  puts "calling..."
  lookup_res = @stub.lookup lookup_req
  puts "call completed"

  puts "The lookup result is #{lookup_res}"
end

puts "*"*72
puts "Make GRPC call in main process"
puts "*"*72
puts ""
print_output

puts "*"*72
puts "Make GRPC call in forked process"
puts "*"*72
puts ""
fork { print_output }
Process.wait
