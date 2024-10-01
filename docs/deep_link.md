# Deep linking

[Deep linking](https://docs.flutter.dev/development/ui/navigation/deep-linking)

```sh
adb shell am start -a android.intent.action.VIEW -c android.intent.category.BROWSABLE -d "https://jagis-front-dev.osc-fr1.scalingo.io/validation-authentification?email=joe@doe.com"
```

```sh
xcrun simctl openurl booted https://jagis-front-dev.osc-fr1.scalingo.io/validation-authentification?email=joe@doe.com
```
