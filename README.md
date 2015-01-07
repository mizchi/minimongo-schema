# minimongo-schema

Load minimongo dbs by schema file

Schema can generate d.ts file.

```
npm install mizchi/minimongo-schema --save-dev
npm install mizchi/minimongo-schema -g # to use minimongo-scheme-gen
```


## CAUTION!

Under my dog fooding

## How to use

sample `schema.coffee`

```coffee
module.exports =
  databases: [
    {
      namespace: 'persist'
      type: 'indexedDb'
      collections: [
        {
          name: 'A'
          params:
            _id: 'string'
        }
      ]
    }
    {
      namespace: 'memory'
      type: 'memoryDb'
      collections: [
        {
          name: 'M'
          params:
            _id: 'string'
            nested:
              a: 'string'
              b:
                c: 'boolean'
        }
      ]
    }
  ]
```

Load dbs by this schema

```coffee
# Initialize
require('minimongo-schema')(require './schema').then (minimongoDbs) ->
  console.log 'initialized'

# Initialize with clean up
require('minimongo-schema')(require('./schema'), true).then (minimongoDbs) ->
  console.log 'initialized with clean up'
```

## Generate typescript definiton

```
$ minimongo-schema-gen schema.coffee -m AAA
declare module AAA {

  export interface A {
    _id: string;
  }
  export interface M {
    _id: string;
    nested: {
      a: string;
      b: {
        c: boolean;
      }
    }
  }
}

```
