# frozen_string_literal: true

require_relative "graphql_to_json/version"

module GraphqlToJson
  class Error < StandardError; end

  def self.convert(graphql)
    File.write("#{__dir__}/input.graphql", parse_many(graphql))
    exec "node #{__dir__}/index.js"
    File.delete("#{__dir__}/input.graphql")

    File.read("#{__dir__}/output.json")
  end

  def self.parse_many(gqls)
    [gqls]
      .flatten
      .map { |gql| parse_one(gql) }
      .join("\n")
  end

  def self.parse_one(gql)
    if File.exist?(gql)
      File.read(gql)
    else
      gql.to_s
    end
  end
end
