import firebase_admin
from firebase_admin import auth

FIREBASE_APP = firebase_admin.initialize_app()


def verify_id_token(token):
    try:
        response = auth.verify_id_token(token, app=FIREBASE_APP)
        print("valid id!")
        return response
    except auth.InvalidIdTokenError:
        print("Provided token was invalid.")
    except auth.ExpiredIdTokenError:
        print("Provided token has expired.")
    except auth.RevokedIdTokenError:
        print("Provided token has been revoked.")
    except auth.CertificateFetchError:
        print("Failed to gather certificates required for verification.")
    return None
