module MongoLike {
  export interface Document {
    _id: string;
  }

  export class Database {
    constructor(private db: any){}

    public addCollection(name: string){
      this.db.addCollection(name);
    }

    public getCollection<T>(name: string): Collection<T>{
      return new Collection<T>(this.db.collections[name]);
    }
  }

  export class Collection<T> {
    constructor(private collection: any){}

    public upsert(obj: T): Promise<T> {
      return new Promise<T>(done => {
        this.collection.upsert(obj, (item) => done(item));
      });
    }

    public remove(id: string): Promise<{}>{
      return new Promise<T>(done => {
        this.collection.remove(id, () => {
          console.info('deleted', id);
          done()
        });
      });
    }

    public find(query?: any): Promise<T[]>{
      return new Promise<T[]>((done) => {
        this.collection.find(query).fetch(items => {
          done(items);
        });
      });
    }

    public findOne(query?: any): Promise<T>{
      return new Promise<T>((d) => {
        this.collection.findOne(query, (item) => {
          d(item);
        });
      });
    }
  }
}

export = MongoLike;
