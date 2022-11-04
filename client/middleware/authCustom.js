export default async function ({ $auth, route, redirect }) {
  let priority = 0
  const user = await $auth.user
  if (user) priority = user.is_admin ? 2 : 1
  const authority = route.meta[0].auth.authority || 0
  if (priority < authority) return redirect('/login')
}
