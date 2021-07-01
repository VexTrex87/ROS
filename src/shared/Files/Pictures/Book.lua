local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Assets = require(ReplicatedStorage.Modules.Assets)

return {
    Name = "Book",
    Type = "Picture",
    Icon = Assets.Book_Stock,
    Source = Assets.Book_Stock,
}