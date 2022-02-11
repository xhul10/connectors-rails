#
# Copyright Elasticsearch B.V. and/or licensed to Elasticsearch B.V. under one
# or more contributor license agreements. Licensed under the Elastic License;
# you may not use this file except in compliance with the Elastic License.
#

require_relative '../../main/ruby/app_config'

RSpec.describe AppConfig do
  let(:message) { 'this is a test message' }

  it "can give the connectors logger" do
    expect { AppConfig.connectors_logger.info { message } }.to output(/#{message}/).to_stdout_from_any_process
  end
end