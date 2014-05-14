part of activerecord;

abstract class Collection {
  DatabaseAdapter _adapter;
  Schema _schema;
  
  Collection() {
    var vars = [Variable.ID_FIELD]..addAll(variables);
    _schema = new Schema(this._tableName, vars);
    _adapter = this.adapter;
    _adapter.createTable(_schema);
  }
  
  Future<Model> saveModel(Model m) => _adapter.saveModel(_schema, m);
  Future<Model> find(int id) => _adapter.findModel(this.nu, id);
  DatabaseAdapter get adapter => defaultAdapter; // Override if needed
  List<Variable> get variables => []; // Override to set Variables in Schema
  String get _tableName => MirrorSystem.getName(reflect(this).type.simpleName);
  Schema get schema => _schema;
  Model get nu => new Model(this);
}