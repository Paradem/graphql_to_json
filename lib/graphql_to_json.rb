require "securerandom"

require_relative "graphql_to_json/version"

module GraphqlToJson
  class Error < StandardError; end

  def self.convert(graphql)
    name = SecureRandom.uuid
    input = "#{__dir__}/#{name}.graphql"
    output = "#{__dir__}/#{name}.json"

    File.write("#{__dir__}/#{name}.graphql", parse_many(graphql))
    `node #{__dir__}/index.js #{name}`
    File.read(output)
  ensure
    File.delete(input) if File.exist?(input)
    File.delete(output) if File.exist?(output)
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
