import test from 'ava';
import graphql from '../common/graphql';

test(t =>
  graphql({query: '{hello}'}).then(result => {
    t.deepEqual(result, {data: {hello: 'world'}})
  })
);
