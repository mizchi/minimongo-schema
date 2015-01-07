minimongo = require 'minimongo'
MemoryDb = minimongo.MemoryDb
IndexedDb = minimongo.IndexedDb
Promise = require 'bluebird'
require('indexeddb-mock').reset()

createIdbCollections = (db, collectionSchemas, withClear = false) ->
  Promise.all collectionSchemas.map (col) -> new Promise (done) ->
    if withClear
      db.removeCollection col.name, ->  db.addCollection col.name, -> done()
    else
      db.addCollection col.name, -> done()

createDb = (schema, withClear = false) -> new Promise (done) ->
  switch schema.type
    when 'indexedDb'
      new IndexedDb {namespace: schema.namespace}, (db) ->
        createIdbCollections(db, schema.collections, withClear)
          .then -> done(db)
    when 'memoryDb'
      db = new MemoryDb()
      for col in schema.collections
        db.addCollection col.name
      done(db)

buildDatabases = (schema, withClear = false) ->
  Promise.all(schema.databases.map (sc) -> createDb(sc, withClear))

module.exports = buildDatabases
