<template>
  <div class="flex justify-center items-center w-full h-full !m-0 bg-[#e0e3e8]">

    <!-- Cart Table -->
    <div class="px-[15px] my-[48px]">
      <!-- Cart Header -->
      <div class="px-[25px] py-[15px] rounded-t-[10px] bg-[#343a40]">
        <div class="flex justify-between items-center text-white">
          <h4 class="inline-block m-0 font-bold text-[20px]">Cart Calculation [{{ itemsCount }}]</h4>
          <button @click="removeAllItems()" class="px-[10px] py-[5px] rounded-[5px] bg-red-500 text-[14px]">
            <font-awesome-icon icon="fa-solid fa-trash-can" class="mr-[4px]" />
            Empty Cart
          </button>
        </div>
      </div>

      <!-- Cart Content -->
      <table class="w-[960px] rounded-b-[10px] bg-white text-left">
        <thead>
          <tr>
            <th>Product</th>
            <th>Name</th>
            <th>Price</th>
            <th class="w-[220px]">Quantity</th>
            <th>Action</th>
            <th class="text-right">Total Amount</th>
          </tr>
        </thead>

        <!-- Cart Items -->
        <tbody>
          <tr v-if="cart.length == 0" class="h-[250px] text-center">
            <td colspan="6">You haven't purchased anything yet...</td>
          </tr>
          <tr v-else v-for="(item, index) in cart" :key="index">
            <td>
              <img :src="`${item.image}`" alt="~/assets/image/book-2.png" class="max-h-[100px]" />
            </td>
            <td>{{ item.title }}</td>
            <td>{{ price(item.price) }}đ</td>
            <td>
              <button class="btn quantityBtn" @click="decreaseQuantityByItem(item.book_id)"
                :disabled="item.quantity <= 0">
                <font-awesome-icon icon="fa-solid fa-minus" />
              </button>
              <input v-model="item.quantity" disabled type="text"
                class="max-w-[70px] min-h-[40px] border-solid border-[1px] border-[#dfe3e7] rounded-[4px] mx-[5px] text-center" />
              <button class="btn quantityBtn" @click="increaseQuantityByItem(item.book_id)">
                <font-awesome-icon icon="fa-solid fa-plus" />
              </button>
            </td>
            <td>
              <button class="btn deleteBtn" @click="removeItemFromCart(item.book_id)">
                <font-awesome-icon icon="fa-solid fa-trash-can" />
              </button>
            </td>
            <td class="text-right">{{ price(item.price * item.quantity) }}đ</td>
          </tr>

          <!-- Total -->
          <tr>
            <th colspan="6" class="!py-[12px] text-right">
              <span>Items in Cart : </span><span class="mr-[50px] text-red-600">{{ totalItemsQuantity }}</span>
              <span>Total Price : </span><span class="text-red-600">{{ price(totalPrice) }}đ</span>
            </th>
          </tr>
        </tbody>
      </table>

      <button class="order-btn">Order Now</button>
    </div>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
export default {
  meta: {
    auth: { authority: 0 }
  },
  computed: {
    ...mapGetters('cart', {
      cart: 'getCartItems',
      itemsCount: 'getItemsCount',
      totalItemsQuantity: 'getTotalItemsQuantity',
      totalPrice: 'getTotalPrice',
    }),
  },
  methods: {
    ...mapActions('cart', {
      increaseQuantityByItem: 'increaseQuantityByItem',
      decreaseQuantityByItem: 'decreaseQuantityByItem',
      removeItemFromCart: 'removeItemFromCart',
      removeAllItems: 'removeAllItems',
    }),
    price(amount) {
      return this.$formatPrice(amount)
    },
  }
}
</script>

<style scoped>
thead>tr>th,
td {
  padding: 10px 25px;
  border-top: 2px solid #dee2e6;
}

tbody>tr>th,
td {
  padding: 5px 25px;
  border-top: 1px solid #dee2e6;
}

.btn {
  width: 40px;
  height: 40px;
  border: none;
  border-radius: 4px;
  font-size: 12px;
  font-weight: bold;
  transition: all 0.3s ease-in-out;
}

.quantityBtn {
  background-color: #5a8dee2e;
  color: #5a8dee;
}

.quantityBtn:hover {
  background-color: #5a8dee;
  color: white;
}

.deleteBtn {
  background-color: #fde6e7;
  color: #ff5b5c;
}

.deleteBtn:hover {
  background-color: #ff5b5c;
  color: #fff;
}

.order-btn {
  float: right;
  color: white;
  background-color: #ff5b5c;
  margin: 30px 0 0 0;
  border: 1.5px solid #ff5b5c;
  border-radius: 5px;
  text-transform: uppercase;
  font-weight: bold;
  padding: 10px 20px;
  transition: all 0.25s;
}

.order-btn:hover {
  background-color: white;
  color: #ff5b5c;
}
</style>