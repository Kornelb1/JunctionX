from django.contrib.auth import authenticate, get_user_model, login, logout
from django.http import HttpResponse
from django.views.decorators.csrf import csrf_exempt

from rest_framework import viewsets, filters, status, mixins
from rest_framework.authtoken.models import Token
from rest_framework.decorators import action
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.throttling import UserRateThrottle

from users.serializers import UserSerializer
from .models import FriendRequest


class UserViewSet(viewsets.ReadOnlyModelViewSet, mixins.UpdateModelMixin):
    """
    This viewset automatically provides `list` and `retrieve` actions.
    """

    queryset = get_user_model().objects.all()
    permission_classes = [IsAuthenticated]
    serializer_class = UserSerializer
    filter_backends = [filters.SearchFilter, filters.OrderingFilter]

    @action(detail=False, methods=["get"], url_path="me", name="me")
    def me(self, request):
        """Get the current authenticated user"""
        serializer = self.get_serializer(request.user)
        return Response(serializer.data)

    @action(methods=["POST"], detail=False)
    def send_friend_request(request, userID):
        from_user = request.user
        to_user = get_user_model().objects.get(id=userID)
        friend_request, created = FriendRequest.objects.get_or_create(from_user=from_user, to_user=to_user)
        if created:
            return Response("Friend Request Sent", status=status.HTTP_200_OK)
        else:
            return Response("Friend Request already sent", status=status.HTTP_200_OK)

    @action(methods=["POST"], detail=False)
    def accept_friend_request(request, requestID):
        friend_request = FriendRequest.objects.get(id=requestID)
        if friend_request.to_user == request.user:
            friend_request.to_user.friends.add(friend_request.from_user)
            friend_request.from_user.friends.add(friend_request.to_user)
            friend_request.delete()
            return Response("Friend Request Accepted")
        else:
            return Response("Friend Request Declined")


class LoginView(APIView):
    permission_classes = ()
    authentication_classes = ()
    throttle_classes = [UserRateThrottle]

    def post(self, request, format=None):
        username = request.data.get("username", None)
        password = request.data.get("password", None)
        print(username, password)
        if username is None or password is None:
            return Response(
                {"message": "Username and password cannot be empty"},
                status=status.HTTP_400_BAD_REQUEST,
            )
        user = authenticate(username=username, password=password)
        if user is not None:
            if user.is_active:
                login(request, user)
                # CsrfViewMiddleware automatically adds csrf token as cookie
                # SessionMiddleware automatically adds session id as cookie
                token, created = Token.objects.get_or_create(user=user)
                return Response(
                    {
                        "message": "Logged in successfully",
                        "user": UserSerializer(user).data,
                        "token": token.key,
                    },
                    status=status.HTTP_200_OK,
                )
            else:
                return Response(
                    {"message": "This account is not active!!"},
                    status=status.HTTP_401_UNAUTHORIZED,
                )
        else:
            return Response(
                {"message": "Invalid username or password!!"},
                status=status.HTTP_401_UNAUTHORIZED,
            )


@csrf_exempt
def logout_view(request):
    logout(request)
    return HttpResponse("Logged out", status=status.HTTP_200_OK)
