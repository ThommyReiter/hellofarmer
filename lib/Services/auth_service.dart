// import 'package:firebase_auth/firebase_auth.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // Registar com e-mail e senha
//   Future<User?> registerWithEmailPassword(String email, String password) async {
//     try {
//       UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
//       return result.user;
//     } catch (e) {
//       print('Erro no registo: $e');
//       return null;
//     }
//   }

//   // Login com e-mail e senha
//   Future<User?> signInWithEmailPassword(String email, String password) async {
//     try {
//       UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
//       return result.user;
//     } catch (e) {
//       print('Erro no login: $e');
//       return null;
//     }
//   }

//   // Resetar Password
//   Future<void> resetPassword(String email) async {
//     try {
//       await _auth.sendPasswordResetEmail(email: email);
//     } catch (e) {
//       print('Erro ao enviar e-mail de recuperação: $e');
//       rethrow;
//     }
//   }

//   // Logout
//   Future<void> signOut() async {
//     await _auth.signOut();
//   }

//   // Obter utilizador atual
//   User? get currentUser => _auth.currentUser;

// }




import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter/material.dart';
import 'package:projeto_cm/Model/custom_user.dart';

class AuthService {
  final fb_auth.FirebaseAuth _auth = fb_auth.FirebaseAuth.instance;

  // Future<CustomUser?> registerWithEmailPassword(String email, String password) async {
  //   try {
  //     fb_auth.UserCredential result =
  //         await _auth.createUserWithEmailAndPassword(email: email, password: password);
  //     final fb_auth.User? user = result.user;

  //     if (user != null) {
  //       return CustomUser(name: "", email: user.email ?? "");
  //     }
  //     return null;
  //   } catch (e) {
      
  //     debugPrint("erro no registo: $e");
  //     return null;
  //   }
  // }

  Future<CustomUser?> registerWithEmailPassword(String email, String password) async {
  try {
    final result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    
    final user = result.user;
    
    if (user != null) {
      return CustomUser(
        id: user.uid,
        name: "", // Default empty name - you can collect this separately
        email: user.email ?? email,
      );
    }
    return null;
  } on fb_auth.FirebaseAuthException catch (e) {
    debugPrint("\n Firebase Auth Error: ${e.code} - ${e.message} \n");
    return null;
  } catch (e) {
    debugPrint("\n General Error: $e \n");
    return null;
  }
}
  

  // Future<CustomUser?> signInWithEmailPassword(String email, String password) async {
  //   try {
  //     fb_auth.UserCredential result =
  //         await _auth.signInWithEmailAndPassword(email: email, password: password);
  //     final fb_auth.User? user = result.user;

  //     if (user != null) {
  //       return CustomUser(""name: "", email: user.email ?? "");
  //     }
  //     return null;
  //   } catch (e) {
      
  //     debugPrint("Erro ao login: $e");
  //     return null;
  //   }
  // }


  Future<CustomUser?> signInWithEmailPassword(String email, String password) async {
  try {
    final result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    
    final user = result.user;
    
    if (user != null) {
      return CustomUser(
        id: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? email,
      );
    }
    return null;
  } on fb_auth.FirebaseAuthException catch (e) {
    debugPrint("\n Firebase Auth Error: ${e.code} - ${e.message} \n");
    return null;
  } catch (e) {
    debugPrint("\n General Error: $e \n");
    return null;
  }
}

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      
      debugPrint("\n Erro ao enviar e-mail de recuperação: $e \n");
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

   CustomUser? get currentUser {
    final user = _auth.currentUser;
    return user != null ? CustomUser.fromFirebaseUser(user) : null;
  }
}
