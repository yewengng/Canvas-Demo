# frozen_string_literal: true

#
# Copyright (C) 2019 - present Instructure, Inc.
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

class AddSubmissionsPostedNotification < ActiveRecord::Migration[5.2]
  tag :predeploy

  def up
    return unless Shard.current == Shard.default

    Canvas::MessageHelper.create_notification({
                                                name: "Submissions Posted",
                                                delay_for: 0,
                                                category: "Grading"
                                              })
  end

  def down
    return unless Shard.current == Shard.default

    Notification.where(name: "Submissions Posted").delete_all
  end
end
