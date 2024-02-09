# frozen_string_literal: true

require_relative "graphql_to_json/version"

module GraphqlToJson
  class Error < StandardError; end

  INPUT = "#{__dir__}/input.graphql"
  OUTPUT = "#{__dir__}/output.json"

  def self.convert(graphql)
    File.write("#{__dir__}/input.graphql", parse_many(graphql))
    `node #{__dir__}/index.js`
  ensure
    output = (File.read(OUTPUT) if File.exist?(OUTPUT))

    File.delete(INPUT) if File.exist?(INPUT)
    File.delete(OUTPUT) if File.exist?(OUTPUT)

    output
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
