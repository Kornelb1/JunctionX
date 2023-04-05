<h2 align="center">Django Backend</h2>


<p align="center">
<a href="https://github.com/psf/black"><img alt="Code style: black" src="https://img.shields.io/badge/code%20style-black-000000.svg"></a>
</p>

---

## 🛠️ Setup

Install Python 3 and Poetry.

```bash
python3 -m pip install venv
python3 -m venv .venv
```

Activate your virtual environment

```bash
.venv/Scripts/activate          # Windows
.venv/bin/activate              # Linux / Mac
```

Use Pip to install the dependencies in your virtualenv.

```bash
cd backend/
pip install -r requirements.txt
```

Set app development as True when developing:

```bash
SET APP_DEVELOPMENT=True         # Windows
$Env:APP_DEVELOPMENT="True"      # Powershell
export APP_DEVELOPMENT=True      # Linux
```

Do your migrations (create your development database):

```bash
python manage.py migrate
```

Run the django server using:

```bash
python manage.py runserver
```

If you wish to host the server locally and have others access it on a public network, make sure you allow the application to bypass the firewall and run the following commands:

Find your ip assigned by the WiFi or network you are on:

```bash
ipconfig        # Windows
ifconfig        # Linux
```

Run the server with a specific port and ip:

```bash
python manage.py runserver 10.173.45.133:8000
```

Access the server from other devices using the IP and Port in a browser.

---

## 🎭 Testing

Navigate to the folder containing manage.py and run:

```bash
python manage.py test
```

Ensure all tests pass. This step can also be done using `coverage run` instead of `python`.

If you wish to run only a specific set of tests, specify the _relative path_. All tests that are discovered within that relative path will be run:

```bash
python manage.py test accounts.tests.views.test_user.AuthenticatedUserViewTest.test_get_user
```

This is of the form `{app}.{path_to_test_file}.{test_file}.{TestClassName}.{UnitTestName}`.

