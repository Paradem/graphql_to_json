const fs = require('fs');
const { buildSchema, introspectionFromSchema} = require('graphql');

const schemaFile = fs.readFileSync('input.graphql', 'utf-8');
const schema = buildSchema(schemaFile);
const introspection = introspectionFromSchema(schema);

fs.writeFileSync('output.json', JSON.stringify(introspection));
