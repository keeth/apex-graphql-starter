import λ from 'apex.js';
import graphql from '../../../common/graphql';

export default λ(event => {
  let request;
  console.log('event', event);
  switch (event.method) {
    case 'GET':
      request = event.query;
      break;
    case 'POST':
      request = event.body;
      break;
    default:
      request = null;
      break;
  }
  if (!request) {
    return Promise.reject(new Error(`Only GET and POST are supported`))
  }
  return graphql(request);
});
