<template>
  <div class="w-full py-[40px] bg-black text-white">
    <div class="container">

      <div class="grid grid-cols-4 gap-[35px]">
        <!-- cols 1/4 - About Us -->
        <div class="space-y-[8px]">
          <h4 class="uppercase">About us</h4>
          <p>
            Lorem ipsum dolor sit amet consectetur adipisicing elit. Nihil sunt
            veniam ea temporibus, eligendi.
          </p>
          <div class="address">
            <span>
              <font-awesome-icon icon="fa-solid fa-map-location-dot" />
            </span>
            <span> 450 fifth Avenue, 34th floor. NYC </span>
          </div>
          <div class="phone">
            <span>
              <font-awesome-icon icon="fa-solid fa-phone" />
            </span>
            <span> (+80) 123 4567 890 </span>
          </div>
          <div class="gmail">
            <span>
              <font-awesome-icon icon="fa-solid fa-envelope" />
            </span>
            <span> vubinhduong261100@gmail.com </span>
          </div>
        </div>

        <!-- Latest-tweets -->
        <div class="space-y-[8px]">
          <h4 class="uppercase">Latest tweets</h4>
          <div class="mb-[12px]">
            <span>
              <font-awesome-icon icon="fa-solid fa-earth-americas" />
            </span>
            <span>
              There are some amazing submissions in the latest
              <span><a class="text-blue-600">@tutsplus ‘Created by you ’challenge http://t.co/duajgjahuz
                  16 hour ago</a></span>
            </span>
          </div>
          <div class="mb-[12px]">
            <span>
              <font-awesome-icon icon="fa-solid fa-earth-americas" />
            </span>
            <span>
              There are some amazing submissions in the latest
              <span><a class="text-blue-700">@tutsplus ‘Created by you ’challenge http://t.co/duajgjahuz
                  16 hour ago</a></span>
            </span>
          </div>
        </div>

        <!-- Information -->
        <div class="space-y-[8px]">
          <h4 class="uppercase">Information</h4>
          <ul class="footer-ul [&>li]:transition-product-card">
            <li>
              <a>Specials</a>
              <font-awesome-icon icon="fa-solid fa-angle-right" />
            </li>
            <li>
              <a>New Products</a>
              <font-awesome-icon icon="fa-solid fa-angle-right" />
            </li>
            <li>
              <a>Best Sellers</a>
              <font-awesome-icon icon="fa-solid fa-angle-right" />
            </li>
            <li>
              <a>Authors</a>
              <font-awesome-icon icon="fa-solid fa-angle-right" />
            </li>
            <li>
              <a>Contact Us</a>
              <font-awesome-icon icon="fa-solid fa-angle-right" />
            </li>
            <li>
              <a>Sitemap</a>
              <font-awesome-icon icon="fa-solid fa-angle-right" />
            </li>
          </ul>
        </div>

        <!-- Latest-tweets -->
        <div class="space-y-[8px]">
          <h4 class="uppercase">Latest tweets</h4>
          <div class="mb-[12px]">
            <span>
              <font-awesome-icon icon="fa-solid fa-earth-americas" />
            </span>
            <span>
              There are some amazing submissions in the latest
              <span><a class="text-blue-600">@tutsplus ‘Created by you ’challenge http://t.co/duajgjahuz
                  16 hour ago</a></span>
            </span>
          </div>
          <div class="mb-[12px]">
            <span>
              <font-awesome-icon icon="fa-solid fa-earth-americas" />
            </span>
            <span>
              There are some amazing submissions in the latest
              <span><a class="text-blue-700">@tutsplus ‘Created by you ’challenge http://t.co/duajgjahuz
                  16 hour ago</a></span>
            </span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {}
</script>

<style scoped>
span {
  font-size: 14px;
  margin-right: 10px;
}
</style>