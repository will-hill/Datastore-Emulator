from google.cloud import ndb
import os
import warnings
warnings.filterwarnings("ignore")


def get_ndb_client() -> ndb.Client:
    project = "emulated"
    os.environ["DATASTORE_EMULATOR_HOST"] = "127.0.0.1:8765"

    ndb_client = ndb.Client(project=project)
    return ndb_client


class Foo(ndb.Model):
    number = ndb.IntegerProperty(required=True, default=-1, indexed=True)
    name = ndb.StringProperty(required=False)
    params = ndb.JsonProperty()


def test_ndb_client() -> None:
    ndb_client = get_ndb_client()
    assert ndb_client is not None


def test_create_foo() -> None:
    with get_ndb_client().context():
        foo = Foo(number=17, params={"key": "val"})
        foo.put()
        foo_id = foo.key.id()
        assert foo_id > -1


def test_query_empty_db() -> None:
    name = "bar"
    with get_ndb_client().context():
        # check name pre-existence
        results = Foo.query().filter(Foo.name == name).get()
        assert results is None
        if results is not None and (type(results) is Foo or len(results) > 0):
            assert False
        foo = Foo(number=23,name=name)
        foo.put()
        foo_id = foo.key.id()
        assert foo_id > -1
