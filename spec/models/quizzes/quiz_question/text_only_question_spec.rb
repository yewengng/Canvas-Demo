# frozen_string_literal: true

#
# Copyright (C) 2013 - present Instructure, Inc.
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

describe Quizzes::QuizQuestion::TextOnlyQuestion do
  let(:question_data) do
    { id: 1 }
  end

  let(:question) do
    Quizzes::QuizQuestion::TextOnlyQuestion.new(question_data)
  end

  describe "#initialize" do
    it "assign question data" do
      expect(question.question_id).to eq question_data[:id]
    end
  end
end
