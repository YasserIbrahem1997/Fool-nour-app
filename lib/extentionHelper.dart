


extension ListUpdate<T> on List {
  List update(int pos, T t) {
    this.removeAt(pos);
    this.insert(pos,t);
    return this;
  }
}