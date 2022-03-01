#
# Copyright Elasticsearch B.V. and/or licensed to Elasticsearch B.V. under one
# or more contributor license agreements. Licensed under the Elastic License;
# you may not use this file except in compliance with the Elastic License.
#

require 'connectors_shared/exception_tracking'

class HelloWorld
  def get_document_batch
    documents = [

      {
        :action => "create_or_update",
        :document => {
          'id' => 'welp_1',
          'title' => 'Traditional Test',
          'body' => 'Hello, world'
        }
      },
      {
        :action => "create_or_update",
        :document => {
          'title' => 'Without Id Test',
          'body' => 'Hello, world'
        }
      },
      {
        :action => "create_or_update",
        :document => {
          'id' => 'welp_3',
          'title' => 'Without Body Test'
        }
      },
      {
        :action => "create_or_update",
        :document => {
          'id' => 'welp_4',
          'body' => 'Without Title Test'
        }
      },
      {
        :action => "create_or_update",
        :document => {
          'id' => 'kitty',
          'title' => 'I would title this kitty as "kittiest kitty of all kitties"',
          'body' => 'kitty does have a body indeed'
        },
        :download => {
          'id' => '1',
          'name' => 'can I download a kitty.jpg',
          'size' => 20971520
        }
      }
    ]
    documents
  end

  def do_risky_thing
    do_risky_thing_helper
  rescue StandardError => e
    ConnectorsExceptionTracking.log_exception(e)
    raise
  end

  def do_risky_thing_helper
    throw_exception
  end

  def throw_exception
    raise "Oh dear, an error"
  end
end