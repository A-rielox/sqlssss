USE LaAppSql;
GO

DROP PROCEDURE IF EXISTS dbo.sp_getUserrMainFoto;
GO

CREATE PROCEDURE dbo.sp_getUserrMainFoto
(
	@userName VARCHAR(50)
)
AS

SET NOCOUNT ON;
SET XACT_ABORT ON;

BEGIN

	SELECT *
	FROM [AppUsers]
	WHERE userName = @userName;

	SELECT pic.*
	FROM [AppUsers] au
	LEFT JOIN [Pictures] pic ON  au.Id = pic.appUserId
	WHERE	userName = @userName
			AND pic.isMain = 1
;

END
GO



EXEC dbo.sp_getUserrMainFoto @userName = 'admin';


/*
MemberDto
{
    public int Id { get; set; }
    public string UserName { get; set; }
    public string PhotoUrl { get; set; }
    public string KnownAs { get; set; }
    public DateTime LastActive { get; set; }
    public string Introduction { get; set; }
    public string Interests { get; set; }
    public string City { get; set; }
    public string Country { get; set; }


    public ICollection<PictureDto> Pictures { get; set; }

var userDto = new UserDto
        {
            UserName = user.UserName,
            KnownAs = user.KnownAs,
            PhotoUrl = user.Pictures.FirstOrDefault(p => p.IsMain == 1)?.Url,
            Token = await _tokenService.CreateToken(user)
        };


		select * from pictures

*/