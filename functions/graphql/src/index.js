import λ from 'apex.js';
import graphql from '../../../common/graphql';
import R from 'ramda';

const requestPropMap = {
  GET: R.prop('query'),
  POST: R.prop('body')
};

const unsupportedMethodError = Promise.reject(new Error('Only GET and POST are supported'));

export default λ(event => {
  const requestProp = requestPropMap[event.method];
  return requestProp ? graphql(requestProp(event)) : unsupportedMethodError;
});
