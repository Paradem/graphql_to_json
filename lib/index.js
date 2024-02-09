import fs from 'fs';
import { buildSchema, introspectionFromSchema} from 'graphql';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const schemaFile = fs.readFileSync(`${__dirname}/input.graphql`, 'utf-8');
const schema = buildSchema(schemaFile);
const introspection = introspectionFromSchema(schema);

fs.writeFileSync(`${__dirname}/output.json`, JSON.stringify(introspection));
