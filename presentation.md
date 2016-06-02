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

