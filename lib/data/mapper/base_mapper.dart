abstract class BaseMapper<T, R> {
  R map(T data);

  R? nullableMap(T? data) {
    return data != null ? map(data) : null;
  }

  List<R> collectionMap(List<T> collection) {
    return collection.map((data) => map(data)).toList();
  }

  List<R>? nullableCollectionMap(List<T>? collection) {
    return collection?.map((data) => map(data)).toList();
  }
}
