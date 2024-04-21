---@diagnostic disable: undefined-global

local did_init = (function()
  local wrap = fmt(
    [==[
      if [[ -z $DID_INIT_{name} ]]; then
        export DID_INIT_{name}=1

        {content}
      fi
    ]==],
    {
      name = i(1, "NAME"),
      content = i(2),
    },
    { repeat_duplicates = true }
  )

  local early_return = fmt(
    [==[
      if [[ -n $DID_INIT_{name} ]]; then
        return
      fi
      export DID_INIT_{name}=1
    ]==],
    {
      name = i(1, "NAME"),
    },
    { repeat_duplicates = true }
  )

  return s("di", c(1, { early_return, wrap }))
end)()

return {
  did_init,
}
