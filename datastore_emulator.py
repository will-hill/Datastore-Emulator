from google.cloud import ndb

ndb_client = ndb.Client(project="test")


class Foo(ndb.Model):
    foo_number = ndb.IntegerProperty(required=True, default=-1, indexed=True)
    params = ndb.JsonProperty()


with ndb_client.context():
    foo = Foo(foo_number=17, params={"key":"val"})
    foo.put()
    foo_id = foo.key.id()
    print(foo_id)
    print("SUCCESS")
