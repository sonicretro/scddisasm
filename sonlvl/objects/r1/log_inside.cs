using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Drawing;
using SonicRetro.SonLVL.API;
using SonicRetro.SonLVL.API.SCD;

namespace SCDObjectDefinitions.R1
{
	public class LogInside : ObjectDefinition
	{
		private Sprite img_ab;
		private Sprite img_cd;

		public override void Init(ObjectData data)
		{
			byte[] art_file = ObjectHelper.OpenArtFile("../src/gfx/r1/log_inside_ab.nem", CompressionType.Nemesis);
			img_ab = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/log_inside.asm", 0, 2);

			art_file = ObjectHelper.OpenArtFile("../src/gfx/r1/log_inside_cd.nem", CompressionType.Nemesis);
			img_cd = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/log_inside.asm", 1, 2);
		}

		public override ReadOnlyCollection<byte> Subtypes
		{
			get { return new ReadOnlyCollection<byte>(new List<byte>()); }
		}

		public override string Name
		{
			get { return "Log Inside"; }
		}

		public override bool RememberState
		{
			get { return false; }
		}

		public override string SubtypeName(byte subtype)
		{
			return string.Empty;
		}

		public override Sprite Image
		{
			get { return (LevelData.Level.TimeZone == SonicRetro.SonLVL.API.TimeZone.Future) ? img_cd : img_ab; }
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			return (LevelData.Level.TimeZone == SonicRetro.SonLVL.API.TimeZone.Future) ? img_cd : img_ab;
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			return (LevelData.Level.TimeZone == SonicRetro.SonLVL.API.TimeZone.Future) ? img_cd : img_ab;
		}
		
		public override int GetDepth(ObjectEntry obj)
		{
			return 6;
		}
	}
}
