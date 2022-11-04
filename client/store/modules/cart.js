let state = {
  cartItems: [],
}

const getters = {
  getCartItems: (state) => state.cartItems,
  getItemsCount: (state) => state.cartItems.length,
  getTotalItemsQuantity: (state) =>
    state.cartItems.reduce((count, { quantity }) => count + quantity, 0),
  getTotalPrice: (state) =>
    state.cartItems.reduce(
      (count, { price, quantity }) => count + price * quantity,
      0
    ),
}

const mutations = {
  init(state) {
    state.cartItems = JSON.parse(localStorage.getItem('_cart_')) || []
  },
  save(state) {
    localStorage.setItem('_cart_', JSON.stringify(state.cartItems))
  },
  addItemToCart(state, item) {
    const findItem = state.cartItems.find((it) => it.book_id === item.book_id)
    if (!findItem) {
      item.quantity = 1
      state.cartItems.push(item)
    } else findItem.quantity++
  },
  increaseQuantityByItem(state, id) {
    const item = state.cartItems.find(({ book_id }) => book_id === id)
    if (item) item.quantity++
    state.cartItems.splice(0, 0)
  },
  decreaseQuantityByItem(state, id) {
    const item = state.cartItems.find((item) => item.book_id === id)
    if (item) item.quantity--
    state.cartItems.splice(0, 0)
  },
  removeItemFromCart(state, id) {
    const item = state.cartItems.find((item) => item.book_id === id)
    if (item) state.cartItems.splice(state.cartItems.indexOf(item), 1)
  },
  removeAllItems(state) {
    state.cartItems = []
  },
}

const actions = {
  init(context) {
    context.commit('init')
  },
  addItemToCart(context, product) {
    context.commit('addItemToCart', product)
    context.commit('save')
  },
  increaseQuantityByItem(context, id) {
    context.commit('increaseQuantityByItem', id)
    context.commit('save')
  },
  decreaseQuantityByItem(context, id) {
    context.commit('decreaseQuantityByItem', id)
    context.commit('save')
  },
  removeItemFromCart(context, id) {
    context.commit('removeItemFromCart', id)
    context.commit('save')
  },
  removeAllItems(context) {
    context.commit('removeAllItems')
    context.commit('save')
  },
}

export default {
  namespaced: true,
  state,
  getters,
  actions,
  mutations,
}
