=begin
Copyright (c) 2023 XAVIER Clément Antoine

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <https://www.gnu.org/licenses/>.
=end

require 'algolia'

class FontAwesomeScrapper
  ALGOLIA_APP_ID = 'M19DXW5X0Q'.freeze
  ALGOLIA_API_KEY = 'c79b2e61519372a99fa5890db070064c'.freeze
  ALGOLIA_INDEX_NAME = 'fontawesome_com-splayed-5.15.4'.freeze

  # Initialize the scrapper
  def initialize
    @algolia_client = Algolia::Search::Client.create(ALGOLIA_APP_ID, ALGOLIA_API_KEY)

    @index = @algolia_client.init_index(ALGOLIA_INDEX_NAME)

    @icons = fetch_icons
  end

  # Return all free icons
  def free_icons
    free_icons = []

    @icons.each do |icon|
      free_icons << icon[:name] if icon[:is_free]
    end

    return free_icons
  end

  private

  # Fetch all icons from Algolia
  def fetch_icons
    nbPages = @index.search('')[:nbPages]

    icons = []

    (0..nbPages).each do |page|
      data = @index.search('', { page: page })

      icons += data[:hits]
    end

    icons
  end
end
