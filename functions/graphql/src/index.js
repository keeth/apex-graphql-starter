import λ from 'apex.js';
import R from 'ramda';
import serializeError from 'serialize-error';
import graphql from '../../../common/graphql';

const responseTransform = {
  errors: R.map(serializeError)
};

const requestTransforms = {
  GET: R.prop('query'),
  POST: R.prop('body')
};

export default λ(event => {
  const requestTransform = requestTransforms[event.method];
  const response = requestTransform ?
    graphql(requestTransform(event)) :
    Promise.resolve({errors: [new Error('Only GET and POST are supported')]});
  return response.then(R.evolve(responseTransform))
});
