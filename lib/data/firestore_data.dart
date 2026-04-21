import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/models/notes_model.dart';
import 'package:uuid/uuid.dart';

class FirestoreData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ignore: non_constant_identifier_names
  Future<bool> CreateUser(String email) async {
    try {
      await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
        'email': email,
        'id': _auth.currentUser!.uid,
      });
      return true;
    } catch (e) {
      log('Error creating user: $e');
      return true;
    }
  }

  Future<bool> addNote(String title, String description) async {
    try {
      var uuid = Uuid().v4();
      DateTime data = DateTime.now();
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .set({
        'id': uuid,
        'title': title,
        'description': description,
        'time': data,
        'isDone': false,
      });
      return true;
    } catch (e) {
      log('Error adding note: $e');
      return true;
    }
  }

  List getNotes(AsyncSnapshot snapshot) {
    try {
      final notesList = snapshot.data.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return NotesModel(
          id: data['id'],
          title: data['title'],
          description: data['description'],
          isDone: data['isDone'],
        );
      }).toList();
      return notesList;
    } catch (e) {
      log('Error getting notes: $e');
      return [];
    }
  }

  Stream<QuerySnapshot> getNotesStream() {
    if (_auth.currentUser == null) {
      log('No user is currently signed in.');
      return Stream.empty();
    }
    try {
      return _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .snapshots();
    } catch (e) {
      log('Error getting notes stream: $e');
      return Stream.empty();
    }
  }

  Future<bool> isDone(String uuid, bool isDone) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .update({
        'isDone': isDone,
      });
      return true;
    } catch (e) {
      log('Error updating note: $e');
      return true;
    }
  }

  Future<bool> updateNote(String uuid, String title, String description) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .update({
        'title': title,
        'description': description,
      });
      return true;
    } catch (e) {
      log('Error updating note: $e');
      return true;
    }
  }

  Future<bool> deleteNote(String uuid) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .delete();
      return true;
    } catch (e) {
      log('Error deleting note: $e');
      return true;
    }
  }
}