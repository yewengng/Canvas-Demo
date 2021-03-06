# frozen_string_literal: true

#
# Copyright (C) 2012 - present Instructure, Inc.
#
# This file is part of Canvas.
#
# Canvas is free software: you can redistribute it and/or modify it under
# the terms of the GNU Affero General Public License as published by the Free
# Software Foundation, version 3 of the License.
#
# Canvas is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
# details.
#
# You should have received a copy of the GNU Affero General Public License along
# with this program. If not, see <http://www.gnu.org/licenses/>.
#

module IncomingMailProcessor
  class MailboxAccount
    attr_writer :address
    attr_accessor :protocol, :config, :error_folder

    class << self
      attr_accessor :default_outgoing_email, :reply_to_enabled
    end

    def initialize(options = {})
      self.protocol     = options[:protocol]
      self.config       = options[:config] || {}
      self.address      = options[:address]
      self.error_folder = options[:error_folder] || "errors"
    end

    def address
      @address ||= self.class.default_outgoing_email
    end

    def escaped_address
      InstStatsd::Statsd.escape(address) unless address.nil?
    end
  end
end
