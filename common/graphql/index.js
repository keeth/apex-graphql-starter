import {graphql} from 'graphql';
import schema from './schema';
import R from 'ramda';
import serializeError from 'serialize-error';

const evolutions = {
  errors: R.map(serializeError)
};

export default (request) =>
  graphql(schema, request.query)
    .then(R.evolve(evolutions));
