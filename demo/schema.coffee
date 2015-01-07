module.exports =
  databases: [
    {
      namespace: 'persist'
      type: 'indexedDb'
      # type: 'memoryDb'
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
      # type: 'indexedDb'
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
