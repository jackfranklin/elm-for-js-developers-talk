![fit](elm_logo.png)

---

## @Jack_Franklin

---

![fit](pusher_cloud.png)

---

![fit](elm_logo.png)

---

## Trends

---

## Complex JavaScript Applications

---

## Two Way Data Binding

---

## MVC / MVVC / MCVCVMMCVCCC

---

## Single source of truth

---

## Views represent state

## `view(state) => HTML`

---

## View functions are pure
## `view(state1) => HTML1`
## `view(state1) => HTML1`
## `view(state2) => HTML2`

---

## Represent user actions

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

## `update(action, state) => newState`

---

## These are pure, too
## `update(a1, s1) => newState1`
## `update(a1, s1) => newState1`

---

## Unidirectional Data Flow

```
user clicks
-> action
-> update(action, state)
-> view(newState)
```

---

## Effects / Async

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

## Effects (or Commands)

## `update(action, state) => (newState, command)`

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

* Functional
* Typed
* Compiled

---

* Expressive, clear code
* Self documenting
* Robust

---

## Expressive, clear code

---

## Self documenting

---

## Robust

---


