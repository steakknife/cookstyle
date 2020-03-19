#
# Copyright:: 2019, Chef Software, Inc.
# Author:: Tim Smith (<tsmith@chef.io>)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
module RuboCop
  module Cop
    module Chef
      module ChefDeprecations
        # Don't depend on the partial_search cookbook made obsolete by Chef 13
        #
        # @example
        #
        #   # bad
        #   depends 'partial_search'
        #
        class CookbookDependsOnPartialSearch < Cop
          MSG = "Don't depend on the deprecated partial_search cookbook made obsolete by Chef 13".freeze

          def_node_matcher :depends_partial_search?, <<-PATTERN
            (send nil? :depends (str "partial_search"))
          PATTERN

          def on_send(node)
            depends_partial_search?(node) do
              add_offense(node, location: :expression, message: MSG, severity: :warning)
            end
          end
        end
      end
    end
  end
end
