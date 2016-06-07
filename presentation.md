![fit](elm_logo.png)

---

## @Jack_Franklin

---

![fit](pusher_cloud.png)

---

![fit](elm_logo.png)

---

## The great tooling problem

---

## We must accept that complex applications are _hard_ to build

---

## And that no tool / language can ever make them truly _easy_

---

## Trends in Complex JavaScript Applications

---

## Two Way Data Binding

---

## `Object.observe`

---

## MVC / MVVC / MCVCVMMCVCCC

---

## "Let's replicate Rails"

---

> We can do better

---

## Component based approach

---

![fit](http://red-badger.com/blog/wp-content/uploads/2015/04/react-logo-1000-transparent.png)

---

## Components

- Angular 2
- Ember
- Vue.js
- React

---

## Explicit about state

---

## Single source of truth

---

## Views represent state<br><br>

## `view(state) => HTML`

---

## View functions are pure<br><br>

## `view(state1) => HTML1`
## `view(state1) => HTML1`
## `view(state2) => HTML2`

---

## Explicitly define all actions that can modify state

```js
function addTodo() {
  return {
    type: 'USER_ADD_TODO',
    text: 'Buy Milk'
  }
}
```

---

## Have `update` functions that can handle actions

```
update(action, state) => newState
```

---

## These are pure, too<br><br>
## `update(a1, s1) => newState1`
## `update(a1, s1) => newState1`

---

## `update` encapsulates most business logic

---

## Unidirectional Data Flow

```
user clicks
-> action
-> update(action, state)
-> view(newState)
```

---

![fit](unidirectional.png)

---

## Side Effects

---

## Async actions

```
user clicks
-> asyncActionFires
-> update(action, state)
-> view(newState)
-> asyncActionReturns
-> update(action, state)
-> view(newState)
```

---

## Explicit Side Effects<br><br>

```
update(action, state) => (newState, command)
```

---

```
user clicks
-> action
-> update(action, state) => (newState, cmdA)
-> view(newState) (cmdARuns)
-> cmdA returns
-> update(action, state) => (newestState, none)
-> view(newestState) || no commands
```

---

## Explicit vs Magic

---

## Magic!

```js
function setNewUser(name) {
  $scope.user = { name : 'jack' };
}
```
---

## Explicit!

```js
function update(action, state) {
  switch (action.type) {
    case 'NEW_USER':
      return Object.assign({}, state, {
        user: { name: action.name }
      });
  }
}
```

---


## Even more explicit!

```
type Msg =
  NewUser String
  | LogOut
```

---

## Even more explicit because the compiler says so

```
update msg model =
  case msg of
    NewUser name ->
      { model | user = name }
```

```
This `case` does not have branches for all possibilities.

22|>    case msg of

You need to account for the following values:

    LogOut

Add a branch to cover this pattern!
```

---

![fit](elm_logo.png)

---

## Elm: a _language_ to solve these problems.

---

![left](sherlock.jpeg)

> Elm, my Dear Watson

-- Sherlock Holmes

---

* Functional
* Typed
* Compiled

---

* Expressive, clear code
* Self documenting
* Robust

---

> Learning curve ahead!

---

## Expressive, clear code

---

## Functional Programming

```js
add(1, 2)
```

```
(add 1 2)
```

---

```
List.map (\x -> x + 2) [1, 2, 3, 4]
```

```
List.map ((+) 2) [1, 2, 3, 4]
```

---

## Pipes

```
incrementWeight (incrementHeight (incrementAge (makePerson "jack")))

makePerson "jack"
|> incrementAge
|> incrementHeight
|> incrementWeight
```

---

## Clean syntax

```
incrementAge person =
  { person | age = person.age + 1 }


add x y = 
  x + y

addTwo =
  add 2
```

---

## Self documenting

---

## Types

```
add : Int -> Int -> Int
isEven : Int -> Bool
```

---

## Union Types

```
type Filter
  = ShowAll
  | ShowCompleted
  | ShowActive

showTodos : Filter -> List Todo -> List Todo
showTodos filter todos =
  case filter of
    ShowAll -> todos
    ShowCompleted -> List.filter (\t -> t.complete) todos
    ShowActive -> List.filter (\t -> not t.complete) todos
```

---

## Union Types

:+1: They can be checked by the compiler (typos are spotted)

:+1: Compiler ensures all are dealt with in `case ... of`

:+1: Easy to change / add a new one: add it and fix each compiler error!

---

## Type variables

```
someFunc : a -> b -> a

someFunc : Int -> Bool -> Int
someFunc : String -> Bool -> String
someFunc : String -> Int -> String
```

---

## Type aliases

```
type alias Person = {
  name : String,
  age : Int
}

incrementAge : Person -> Person
incrementAge person =
  { person | person.age = person.age + 1 }
```

---

:+1: Clearer code, typed in your domain specific objects.

:+1: Compiler can guarantee you're meeting the type requirements.

:+1: No more 'undefined is not a function' !

---

## Robust

---

## Immutability brings guarantees

```js
var person = { name: 'Jack', age: 24 };

incrementAge(person);

// has this mutated?
// does it return a new person?
// #javascript
```

---

## Sweet, sweet Elm

```
let
  person = { name = "Jack", age = 24 }
in
  incrementAge person
```

:+1: `person` is untouched
:+1: `incrementAge` has to return a new person
:+1: goodbye mutation bugs

---

## Dealing with nothing

No more null.

---

## Maybe

```
type Maybe a =
  Just a
  | Nothing

```

It's either `Just` some value, or `Nothing`.

---

## Maybe

```
type alias Model = {
  user : Maybe User
}

view : Model -> Html Msg
view model =
  case model.user of 
    Nothing ->
      div [] [ text "No user!" ]
    Just user ->
      div [] [ text ("Logged in as " ++ user.name) ]
```

---

## You must handle all cases of missing / pending data

---

## Task

A module for async actions that might fail (HTTP).

```
Task errType successType
```

```
Task String User
- if it fails, fail with a String
- if it succeeds, succeed with a User
```

---

## You have to deal with errors.

`Task` doesn't let you not.

(We'll come back to this later).

---

## Reactivity

- Data changes
- Async activities

---

## Commands and Subcriptions

- `Cmd` : an async thing that Elm should run for you
- `Sub` : a subscription to some data you care about that might change

---

## Adjustment time

This does take time to get used to

* Syntax
* Types
* Immutablility
* Compiling!
* `Maybe` and explicit error handling

---

```
user clicks
-> action
-> update(action, state)
-> view(newState) || run command
-> command causes new action
-> update(action, state)
-> view(newState) || no commands
```

---

## The Elm Architecture

---

The three parts:

```
model : Model
view : Model -> Html Msg
update : Msg -> Model -> Model

```

---

## Counter

---

## Live coding...

---

## Use these slides if the live coding goes dreadfully

---

First, define your `Model`

```
type alias Model = Int

initialModel : Model
initialModel = 0
```

---

Secondly, define your `Msg`s

```
type Msg = Increment | Decrement
```

---

Thirdly, define your `update`:

```
update : Msg -> Model -> Model
update msg model =
  case msg of 
    Increment -> model + 1
    Decrement -> model - 1
```

---

Fourthly, define your `view`:

```
view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , div [] [ text (toString model) ]
    , button [ onClick Increment ] [ text "+" ]
    ]
```
---

Finally, hook it all up!

```
main =
  Html.App.beginnerProgram
    { model = initialModel
    , view = view
    , update = update
    }
```

---

:+1: We left the `view` until last.
:+1: Explained all our logic before the UI.
:+1: Notice how easy `update` would be to test.

---

## Commands

---

Whenever you need to perform some background work, you have to give Elm a command.

Elm will go off, perform the command, and call your `update` function once it's done.

---

## Fetching someone's GitHub data.

---

Firstly, define the model:

```
type alias GithubPerson =
  { name : String
  , company : String
  }

type alias Model =
  { username : String
  , githubPerson : Maybe GithubPerson
  }
```

---

Secondly, define your `Msg`s

```
type Msg
  = NewGithubData GithubPerson
  | FetchGithubData
  | FetchError Http.Error
```

---

Thirdly, define your `update` (and note the new type)

```
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    FetchError error ->
      -- deal with error here in reality

    NewGithubData person ->
      ( { model | githubPerson = Just person }, Cmd.none )

    FetchGithubData ->
      ( model, fetchGithubData model.username )
```

---

Fourthly, define your `view`:

```
view : Model -> Html Msg
view model =
  case model.githubPerson of
    Just person ->
      div []
        [ text (person.name ++ ", " ++ person.company) ]
    Nothing ->
      div [] [
        button [ onClick FetchGithubData ] [ text "Load!" ]
      ]
```

---

Fifthly (new step), define  your `init`:

```
initialModel : Model
initialModel =
  { username = "jackfranklin"
  , githubPerson = Nothing
  }


init : ( Model, Cmd Msg )
init =
  ( initialModel, Cmd.none )
```

---

Finally, hook it all together!

```
main = 
  Html.App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = \_ -> Sub.none
    }
```

---

![fit autoplay loop](github-person-works.mov)

---

> That feels like a lot of code!

-- All of you.

---

> Boilerplate vs Explicitness

---

> Benefits increase as application grows

---

## Fetching Data

---

## Decoding JSON

```
githubDecoder : Json.Decoder GithubPerson
githubDecoder =
  Json.object2 GithubPerson
    ("name" := Json.string)
    ("company" := Json.string)

```
---

## Making the request

```
fetchGithubData : String -> Cmd Msg
fetchGithubData username =
  Http.get githubDecoder (apiUrl username)
      |> Task.perform FetchError NewGithubData
```

---

#### `Http.get : Json.Decode.Decoder a -> String -> Task Http.Error a`

- takes a decoder that decodes into type `a` and a string (the URL)
- returns a `Task` that either fails with `Http.Error` or succeeds with type `a`

---

#### `Task.perform : (a -> Msg) -> (c -> Msg) -> Task a c -> Cmd Msg`
#### `Task.perform : errorHander successHandler task`

- takes a task that will fail or succeed
- takes an error function that can convert the failure to a `Msg`
- takes a success function that can convert the success to a `Msg`
- Returns a `Cmd` that will perform the task in the background.

---

### `github.com/jackfranklin/elm-for-js-developers`

---

## Scaling your application

---

> It's just components all the way down!

---

## The Elm Ecosystem

---

## `elm reactor`

Easily run a project in the browser with no tooling required.

---

```
elm package
```

Semantic versioning ensured.

```
~/git/elm-statey > elm package diff
Comparing jackfranklin/elm-statey 2.0.0 to local changes...
This is a MAJOR change.

------ Changes to module Statey - MAJOR ------

    Changed:
      - makeState : String -> Statey.State
      + makeState : Statey.State

```

---

## `elm format`

---

## There's so much more I haven't covered.

---

> So, why / when should you use Elm?

---

> You're fed up of `undefined function` errors that take up loads of time

---

> You're fed up of packages on npm breaking semantic versioning

---

> You want to develop with the confidence of Types and a clever compiler to back you up

---

> You're happy to "ride the wave" and deal with a language still growing and settling down

---

> You're happy to build more packages than depend on existing solutions which may not exist in Elm

---

# But what if this talk has put me off Elm?

---

## Elm does take time to learn, so please don't give up after 30 minutes of slides!

### guide.elm-lang.org

---

## Elm the language brings many concepts that are language agnostic

---

## The Elm Architecture

---

## Explicitness across your application

---

## Types

---

## Immutability / Functional Programming

---

## Defining your application step by step

1. Define your model.
2. Define your actions.
3. Define your update function.
4. Define your view.
5. Repeat.

---

## Will everyone be writing Elm in 1/2/5 years?

---

# @Jack_Franklin

## javascriptplayground.com

#### javascriptplayground.com/elm-jscamp.html

---

# 🇷🇴 Thank you 🇷🇴


