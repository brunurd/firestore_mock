import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_platform_interface/cloud_firestore_platform_interface.dart'
    as platform;
import 'package:firestore_mock/src/mock_collection.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';

class MockDocumentSnapshot extends Mock implements DocumentSnapshot {
  final Map<String, dynamic> data;
  final String documentID;
  final DocumentReference reference;

  MockDocumentSnapshot.fromRef(MockDocumentReference mockReference)
      : data = mockReference.data,
        documentID = mockReference.documentID,
        reference = mockReference;
}

class MockDocumentReference extends Mock implements DocumentReference {
  Map<String, dynamic> data;
  final String documentID;

  MockDocumentReference({@required this.documentID, @required this.data});

  @override
  Future<DocumentSnapshot> get({
    platform.Source source = platform.Source.serverAndCache,
  }) =>
      Future.value(MockDocumentSnapshot.fromRef(this));

  // @override
  // Stream<DocumentSnapshot> snapshots() {
  //   return Stream.fromFuture(get());
  // }

  @override
  Future<void> delete() async {
    //TODO: Propagate remove from MockFirestore data
    // Now: Do nothing
  }

  @override
  Future<void> updateData(Map<String, dynamic> data) async {
    this.data = data;
  }

  @override
  CollectionReference collection(String collectionPath) {
    final collectionData = data[collectionPath] as Map<String, dynamic>;

    return MockCollectionReference(
        collection: path, firestore: null, data: collectionData);
  }
}
