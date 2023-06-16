import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sport_lottery/features/auth/data/auth_repo.dart';
import 'package:sport_lottery/features/auth/data/user_model.dart';
import 'package:sport_lottery/helpers/saved_data.dart';

class AuthUseCase {
  GetAuthRepo getAuthRepo;
  AuthUseCase(this.getAuthRepo);
  Future<UserModel> setUser(GoogleSignInAuthentication googleAuth) async {
    OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    UserModel user = UserModel(
      email: userCredential.user!.email!,
      name: userCredential.user!.displayName!,
      image: userCredential.user!.photoURL!,
      uid: userCredential.user!.uid,
      date: DateTime.now().toString(),
    );

    UserModel? userFrom = await getAuthRepo.setUser(user);

    if (userFrom != null) {
      user = userFrom;
    }

    await SavedData.setUid(user.uid);
    await SavedData.setName(user.name);
    await SavedData.setEmail(user.email);
    await SavedData.setImage(user.image);

    return user;
  }
}
