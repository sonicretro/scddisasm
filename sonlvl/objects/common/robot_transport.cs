using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Drawing;
using SonicRetro.SonLVL.API;
using SonicRetro.SonLVL.API.SCD;

namespace SCDObjectDefinitions.Common
{
	public class RobotTransporter : ObjectDefinition
	{
		private Sprite img_present;
		private Sprite img_past;

		public override void Init(ObjectData data)
		{
			byte[] art_file = ObjectHelper.OpenArtFile("../src/gfx/robot_transport_a.nem", CompressionType.Nemesis);
			img_present = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/robot_transport.asm", 2, 0);

			art_file = ObjectHelper.OpenArtFile("../src/gfx/robot_transport_b.nem", CompressionType.Nemesis);
			img_past = ObjectHelper.MapASMToBmp(art_file, "../src/sprites/robot_transport.asm", 3, 0);
		}

		public override ReadOnlyCollection<byte> Subtypes
		{
			get { return new ReadOnlyCollection<byte>(new List<byte>()); }
		}

		public override string Name
		{
			get { return "Robot Transporter"; }
		}

		public override bool RememberState
		{
			get { return false; }
		}

		public override string SubtypeName(byte subtype)
		{
			return string.Empty;
		}
		
		public Sprite SetupSprite(bool present)
		{
			if (present)
				return new Sprite(img_present, false, false);
			return new Sprite(img_past, false, false);
		}

		public override Sprite Image
		{
			get { return SetupSprite(false); }
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			return SetupSprite(false);
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			return SetupSprite(LevelData.Level.TimeZone == SonicRetro.SonLVL.API.TimeZone.Past);
		}
	}
}