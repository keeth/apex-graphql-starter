import {graphql} from 'graphql';
import schema from './schema';

export default (request) => graphql(schema, request.query);
